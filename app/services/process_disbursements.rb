class ProcessDisbursements
    def initialize(merchant_id, from_date, to_date)
        @merchant_id = merchant_id
        @from_date = from_date
        @to_date = to_date
    end

    def call
        # First we find the orders that are completed withing given date range
        # and do not have a disbursement created yet (to prevent duplicates).
        completed_orders = find_completed_orders

        # We loop through the orders to create the respective disbursements.
        disbursements = []
        completed_orders.each do |order|
            amount_to_disburse = calculate_amount(order.amount)
            disbursements << Disbursement.new(order: order, amount: amount_to_disburse, processed_at: Time.zone.now)
        end

        # I don't really like the idea of throwing a potential n+1, to scale we could
        # create another service just for the saves and try things like batches, but
        # a transaction block at least adds some reliability to this.
        Disbursement.transaction do
            disbursements.each(&:save!)
        end
    end

    private

    def find_completed_orders
        Order.from_merchant(@merchant_id).where('completed_at BETWEEN ? AND ?', @from_date, @to_date).
        left_joins(:disbursements).where(disbursements: { amount: nil })
    end

    def calculate_amount(amount)
        # We shouldn't create a method that's only an 'if' or 'case' statement, so we return when it's the case.

        # The fee is 1% when amount is lower than 50$.
        return amount - (amount * 0.01) if amount < 50

        # The fee is 0.85% when amount is higher than 300$.
        return amount - (amount * 0.0085) if amount > 300

        # The fee is 0.95% when amount is between the two above values.
        amount - (amount * 0.0095)
    end
end