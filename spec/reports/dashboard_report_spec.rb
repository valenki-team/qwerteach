require 'rails_helper'

RSpec.describe DashboardReport, type: :report do

  subject { DashboardReport.run(start_date: (days - 1).days.ago.to_date) }
  let(:result) { subject.result }

  describe 'Lessons' do
    let!(:yestarday_lessons) do
      Timecop.freeze(1.days.ago) { create_list(:lesson, 2, :paid, :today) }
    end

    let!(:before_yestarday_lessons) do
      Timecop.freeze(2.days.ago) { create_list(:lesson, 2, :paid, :today) }
    end

    let!(:today_lessons) { create_list(:lesson, 2, :today) }

    let(:days) { 3 }

    it 'returns filled entities for 2 days' do
      expect(subject).to be_valid
      expect(result.size).to eq(days)

      expect(result[0].as_json.symbolize_keys).to include(
        period: 2.days.ago.beginning_of_day,
        lessons_count: 2,
        lessons_amount: yestarday_lessons.sum(&:price)
      )

      expect(result[1].as_json.symbolize_keys).to include(
        period: 1.days.ago.beginning_of_day,
        lessons_count: 2,
        lessons_amount: before_yestarday_lessons.sum(&:price)
      )
    end

    it 'does not return not created lessons' do
      expect(result[2].as_json.symbolize_keys).to include(
        period: Time.current.beginning_of_day,
        lessons_count: 0,
        lessons_amount: 0
      )
    end
  end

end