rails g model Suppliers name:text{255} import_identifier:text{255}
rails g model Attributes
rails g model SupplierAttributes foreign_id:text{255} supplier:references attribute:references
rails g model SupplierCategories parent_id:integer name:text{255} foreign_id:text{255} lft:integer lvl:integer rgt:integer root:integer supplier:references
rails g model SupplierItems variation_id:integer measurment_unit:text{255} payload:text{65535} supplier_category:references supplier:references
rails g model Categories parent_id:integer name:text{255} is_visible:boolean foreign_id:text{100} slug:text{500} depth:integer identifier:text{255} priority:integer description:text{65535} display_rule:text{255} family_id:integer
rails g model CategoriesMap supplier_category:references category:references
