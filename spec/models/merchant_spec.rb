require 'rails_helper'

describe Merchant do
    describe 'Associations' do
        it { should have_many(:orders) }
        it { should have_many(:shoppers) }
    end

    describe 'Validations' do
        context 'with valid parameters' do
            let(:merchant) { create(:merchant) }

            it 'it is valid' do
                expect(merchant).to be_valid
            end
        end

        context 'with invalid parameters' do
            it 'it\'s not valid without name' do
                merchant = Merchant.new(
                    email: Faker::Internet.email,
                    cif: Faker::Alphanumeric.alphanumeric
                )

                expect(merchant).to_not be_valid
            end

            it 'it\'s not valid without email' do
                merchant = Merchant.new(
                    name: Faker::Name.name,
                    cif: Faker::Alphanumeric.alphanumeric
                )

                expect(merchant).to_not be_valid
            end

            it 'it\'s not valid without cif' do
                merchant = Merchant.new(
                    name: Faker::Name.name,
                    email: Faker::Internet.email
                )

                expect(merchant).to_not be_valid
            end
        end
    end
end