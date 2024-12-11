require "csv"

Product.delete_all
Category.delete_all

filename = Rails.root.join("db/sports_equipment.csv")

puts "Loading data from this file: #{filename}"
