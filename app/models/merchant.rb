class Merchant < ApplicationRecord
    has_many :orders
    has_many :shoppers, through: :orders

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :cif, presence: true, uniqueness: true
end
