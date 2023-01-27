FactoryBot.define do
    factory :merchant do
        name { Faker::Name.name }
        email  { Faker::Internet.email }
        cif { Faker::Alphanumeric.alphanumeric }
    end

    factory :shopper do
        name { Faker::Name.name }
        email  { Faker::Internet.email }
        nif { Faker::Alphanumeric.alphanumeric }
    end

    factory :order do
        merchant
        shopper
        amount { Faker::Number.decimal(r_digits: 2) }
        completed_at { Faker::Date.in_date_period }
    end
  end