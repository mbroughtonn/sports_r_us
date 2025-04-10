require "csv"

Product.delete_all
Brand.delete_all
Category.delete_all
Page.delete_all

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
      name: product["product_name"],  # Use the name field instead of title
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

Page.create(title: "About Us", content: "This is our about page. All about sports equipment products!", permalink: "about_us")
Page.create(title: "Contact Us", content: "Contact me at mbroughton@rrc.ca", permalink: "contact_us")

puts "There are #{Product.count} Products."
puts "There are #{Brand.count} Brands."
puts "There are #{Category.count} Categories."
puts "There are #{Page.count} Pages."
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?