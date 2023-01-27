class Shopper < ApplicationRecord
    has_many :orders
    has_many :merchants, through: :orders

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :nif, presence: true, uniqueness: true
end
