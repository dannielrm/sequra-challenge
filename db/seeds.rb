# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

unless Merchant.take
    file = File.read('./storage/merchants.json')
    parsed_file = JSON.parse(file)
    parsed_file['RECORDS'].each do |row|
        Merchant.create(id: row['id'], name: row['name'], email: row['email'], cif: row['cif'])
    end
end

unless Shopper.take
    file = File.read('./storage/shoppers.json')
    parsed_file = JSON.parse(file)
    parsed_file['RECORDS'].each do |row|
        Shopper.create(id: row['id'], name: row['name'], email: row['email'], nif: row['nif'])
    end
end

unless Order.take
    file = File.read('./storage/orders.json')
    parsed_file = JSON.parse(file)
    parsed_file['RECORDS'].each do |row|
        Order.create(
            id: row['id'],
            merchant_id: row['merchant_id'],
            shopper_id: row['shopper_id'],
            amount: row['amount'].to_f,
            created_at: row['created_at'],
            completed_at: row['completed_at'],
        )
    end
end