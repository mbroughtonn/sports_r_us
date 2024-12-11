require "csv"

Product.delete_all
Brand.delete_all
Category.delete_all

filename = Rails.root.join("db", "sports_equipment.csv")
puts "Loading data from this file: #{filename}"

csv_data = File.read(filename)
products = CSV.parse(csv_data, headers: true, encoding: "utf-8")

products.each do |product|
  brand = Brand.find_or_create_by(name: product["brand_name"])
  category = Category.find_or_create_by(name: product["category_name"])

  if brand.valid? && category.valid?
    # Create the product
    new_product = Product.create(
      title: product["product_name"],
      description: product["description"],
      price: product["price"].to_f,  # Ensure it's a float
      stock_quantity: product["stock_quantity"].to_i,  # Ensure it's an integer
      brand: brand,  # Assign the brand association
      category: category # Assign the category association
    )

    if new_product.errors.any?
      puts "Unable to create product: #{product["product_name"]}, Errors: #{new_product.errors.full_messages.join(", ")}"
    end
  else
    puts "This Brand has errors: #{product['brand_name']}" unless brand.valid?
    puts "This Category has errors: #{product['category_name']}" unless category.valid?
  end
end

puts "There are #{Product.count} Products."
puts "There are #{Brand.count} Brands."
puts "There are #{Category.count} Categories."
