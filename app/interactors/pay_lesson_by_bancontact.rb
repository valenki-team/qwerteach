class PayLessonByBancontact < ActiveInteraction::Base
  include PayLessonNotification

  object :user, class: User
  object :lesson, class: Lesson
  integer :transaction_id

  attr_reader :mango_transaction, :payment

  def execute
    @mango_transaction = Mango.normalize_response(MangoPay::PayIn.fetch(transaction_id))
    if @mango_transaction.status != 'SUCCEEDED'
      return errors.add(:base, I18n.t('notice.transaction_error'))
    end
    if (@mango_transaction.credited_funds.amount / 100.0) != lesson.price
      return errors.add(:base, I18n.t('notice.transaction_error'))
    end
    Lesson.transaction do
      lesson.created! if lesson.pending_student?
      return self.errors.merge!(lesson.errors) if !lesson.save
      @payment = Payment.new payment_params
      if !payment.save
        self.errors.merge! payment.errors
        raise ActiveRecord::Rollback
      end
    end
    return @mango_transaction
  end

  private

  def amount
    lesson.price
  end

  def payment_params
    {
      payment_type: lesson.past? ? :postpayment : :prepayment,
      payment_method: :bcmc,
      status: lesson.past? ? :paid : :locked,
      lesson_id: lesson.id,
      transfert_date: DateTime.now,
      price: amount,
      mangopay_payin_id: transaction_id,
      transactions: [mango_transaction]
    }
  end
end