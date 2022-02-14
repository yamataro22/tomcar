class AddForeignKeyToSubcategories < ActiveRecord::Migration[6.1]
  add_column :subcategories, :category_id, :integer
end
