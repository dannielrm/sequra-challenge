require 'rails_helper'

describe Shopper do
    describe 'Associations' do
        it { should have_many(:orders) }
        it { should have_many(:merchants) }
    end

    describe 'Validations' do
        context 'with valid parameters' do
            let(:shopper) { create(:shopper) }
            it 'it is valid' do
                expect(shopper).to be_valid
            end
        end

        context 'with invalid parameters' do
            it 'it\'s not valid without name' do
                merchant = Shopper.new(
                    email: Faker::Internet.email,
                    nif: Faker::Alphanumeric.alphanumeric
                )

                expect(merchant).to_not be_valid
            end

            it 'it\'s not valid without email' do
                merchant = Shopper.new(
                    name: Faker::Name.name,
                    nif: Faker::Alphanumeric.alphanumeric
                )

                expect(merchant).to_not be_valid
            end

            it 'it\'s not valid without nif' do
                merchant = Shopper.new(
                    name: Faker::Name.name,
                    email: Faker::Internet.email
                )

                expect(merchant).to_not be_valid
            end
        end
    end
end