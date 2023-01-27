require 'rails_helper'

describe Order do
    describe 'Associations' do
        it { should belong_to(:merchant) }
        it { should belong_to(:shopper) }
        it { should have_many(:disbursements) }
    end

    describe 'Validations' do
        it { should validate_presence_of(:merchant) }

        it { should validate_presence_of(:shopper) }
    end
end