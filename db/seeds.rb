# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Supplier.destroy_all
Supplier.create!([{

  name: "Icecat",
  import_identifier: "icecat"
}
])

Shop.destroy_all
Shop.create!([{

  name: "Elfas",
  uuid: SecureRandom.uuid,
  locale: "lt"
}
])

SupplierCategory.destroy_all
SupplierCategory.create!([{
    name: "Icecat",
    foreign_id: "123",
    supplier_id: 1,
    root: 1
}
])

Category.destroy_all
@category = Category.create!([{
    name: "Icecat",
    is_visible: true,
    foreign_id: "123",
    slug: "icecat",
    depth: 1,
    identifier: "icecat",
    priority: 0,
    uuid: SecureRandom.uuid
}
])

CategoriesMap.destroy_all
CategoriesMap.create!([{
    supplier_category_id: 1,
    seller_category_id: 1
}
])

p "Created #{Supplier.count} suppliers"
p "Created #{Shop.count} shop"
p "Created #{SupplierCategory.count} supplier category"
p "Created #{Category.count} category"
