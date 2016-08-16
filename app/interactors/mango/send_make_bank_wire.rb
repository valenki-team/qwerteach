module Mango
  class SendMakeBankWire < ActiveInteraction::Base
    object :user, class: User
    integer :amount
    integer :fees, default: 0

    set_callback :execute, :before, :check_mango_account

    def execute
      payin = Mango.normalize_response MangoPay::PayIn::BankWire::Direct.create(mango_params)
      if %w(SUCCEEDED CREATED).exclude? payin.status
        self.errors.add(:base, payin.result_message)
      end
      payin
    rescue MangoPay::ResponseError => error
      message = error.details['Message']
      message += error.details['errors'].map{|name, val| " #{name}: #{val} \n\n"}.join
      self.errors.add(:base, message)
    end

    private

    def check_mango_account
      raise Mango::UserDoesNotHaveAccount if user.mango_id.blank?
    end

    def credited_wallet
      user.mangopay.normal_wallet
    end

    def mango_params
      {
        :author_id => user.mango_id.to_s,
        :declared_debited_funds => {
            :currency => "EUR",
            :amount => amount * 100
        },
        :declared_fees => {
            :currency => "EUR",
            :amount => fees * 100
        },
        :credited_wallet_id => credited_wallet.id
      }.camelize_keys
    end

  end
end