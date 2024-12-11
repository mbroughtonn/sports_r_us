require "csv"

# Clear existing data
Product.delete_all
Category.delete_all

# Path to your CSV file
filename = Rails.root.join("db", "sports_equipment.csv")

puts "Loading data from this file: #{filename}"

# Read the CSV file
csv_data = File.read(filename)
products = CSV.parse(csv_data, headers: true, encoding: "utf-8")

# Loop through each product in the CSV
products.each do |product|
  # Find or create the category based on the category name from the CSV
  category = Category.find_or_create_by(name: product["category"])

  if category.valid?
    # Create the product associated with the category
    new_product = category.products.create(
      title: product["product_name"],      # Assuming "product_name" is the title
      description: product["description"], # Assuming your Product model has a description column
      price: product["price"],
      stock_quantity: product["stock_quantity"]
    )

    if !new_product.valid?
      puts "Unable to create product: #{product['product_name']}"
    end
  else
    puts "This Category has errors: #{product['category']}"
  end
end

# Output the count of products and categories created
puts "There are #{Product.count} products."
puts "There are #{Category.count} categories."
