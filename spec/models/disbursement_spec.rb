require 'rails_helper'

describe Disbursement do
    describe 'Associations' do
        it { should belong_to(:order) }
        it { should have_one(:merchant) }
        it { should have_one(:shopper) }
    end
end