class Disbursement < ApplicationRecord
    belongs_to :order
    has_one :merchant, through: :order
    has_one :shopper, through: :order
end
