
categories = Category.create([
  { name: 'Vitamins' },
  { name: 'Minerals' },
  { name: 'Proteins' },
  { name: 'Amino Acids' }
])


products = [
  { name: 'Vitamin C 500mg', description: 'Boost your immune system with high-quality Vitamin C.', price: 15, category: categories[0], image_file: 'vitamin_c.png' },
  { name: 'Magnesium Glycinate', description: 'Supports muscle relaxation and healthy sleep.', price: 25, category: categories[1], image_file: 'magnesium.png' },
  { name: 'Whey Protein', description: 'A rich source of protein for muscle recovery and growth.', price: 45, category: categories[2], image_file: 'whey_protein.png' },
  { name: 'BCAA 2:1:1', description: 'Enhance muscle recovery with essential branched-chain amino acids.', price: 30, category: categories[3], image_file: 'bcaa.png' },
  { name: 'Omega-3 Fish Oil', description: 'Boost your cardiovascular health with high-quality fish oil.', price: 20, category: categories[0], image_file: 'omega3.png' },
  { name: 'Zinc Picolinate', description: 'Support immune health and better absorption with zinc picolinate.', price: 18, category: categories[1], image_file: 'zinc.png' },
  { name: 'Plant-Based Protein', description: 'A vegan-friendly protein to support your active lifestyle.', price: 35, category: categories[2], image_file: 'plant_protein.png' },
  { name: 'Glutamine Powder', description: 'Improve muscle recovery with pure glutamine powder.', price: 25, category: categories[3], image_file: 'glutamine.png' },
  { name: 'Vitamin D3 1000 IU', description: 'Promote healthy bones and immune function with Vitamin D3.', price: 12, category: categories[0], image_file: 'vitamin_d3.png' },
  { name: 'Calcium Citrate', description: 'Support bone health with easily absorbed calcium citrate.', price: 22, category: categories[1], image_file: 'calcium.png' }
]


products.each do |product_data|
  product = Product.create!(
    name: product_data[:name],
    description: product_data[:description],
    price: product_data[:price],
    category: product_data[:category]
  )
  product.image.attach(
    io: File.open(Rails.root.join('app', 'assets', 'images', product_data[:image_file])),
    filename: product_data[:image_file]
  )
end

puts "Seed data successfully created!"
