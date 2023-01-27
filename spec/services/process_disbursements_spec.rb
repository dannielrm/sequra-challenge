require 'rails_helper'

RSpec.describe ProcessDisbursements, type: :model do
  describe '#call' do
    let!(:merchant) { create(:merchant) }
    let!(:shopper) { create(:shopper) }

    before do
        create(:order, merchant: merchant, shopper: shopper, completed_at: nil)
        create(:order, merchant: merchant, shopper: shopper, completed_at: Time.zone.now)
        create(:order, merchant: merchant, shopper: shopper, completed_at: Time.zone.now)
        create(:order, merchant: merchant, shopper: shopper, completed_at: Time.zone.now)
        create(:order, merchant: merchant, shopper: shopper, completed_at: Time.zone.now + 7.days)
    end

    it 'correctly creates a disbursement for each order', :aggregate_failures do
        described_class.new(merchant.id, Date.today.at_beginning_of_day, Date.today.at_beginning_of_day + 7.days).call

        expect(Disbursement.all.count).to eq(3)
    end

    it 'correctly calculates the disbursement based on the fee', :aggregate_failures do
        # The fee is 1% when amount is lower than 50$.
        create(:order, merchant: merchant, shopper: shopper, completed_at: Time.zone.now, amount: 10)
        described_class.new(merchant.id, Date.today.at_beginning_of_day, Date.today.at_beginning_of_day + 7.days).call
        expect(Disbursement.last.amount.to_f).to eq(9.9)

        # The fee is 0.95% when amount is between 50$ and 300$.
        create(:order, merchant: merchant, shopper: shopper, completed_at: Time.zone.now, amount: 100)
        described_class.new(merchant.id, Date.today.at_beginning_of_day, Date.today.at_beginning_of_day + 7.days).call
        expect(Disbursement.last.amount.to_f).to eq(99.05)

        # The fee is 0.85% when amount is higher than 300$.
        create(:order, merchant: merchant, shopper: shopper, completed_at: Time.zone.now, amount: 1000)
        described_class.new(merchant.id, Date.today.at_beginning_of_day, Date.today.at_beginning_of_day + 7.days).call
        expect(Disbursement.last.amount.to_f).to eq(991.5)
    end
  end
end