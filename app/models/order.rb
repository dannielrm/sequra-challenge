class Order < ApplicationRecord
    belongs_to :merchant
    belongs_to :shopper
    has_many :disbursements

    validates :merchant, presence: true
    validates :shopper, presence: true

    scope :from_merchant, -> (merchant_id) { where(merchant_id: merchant_id)}
end
