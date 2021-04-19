class AddConstraintUniqueToProductAttributesNames < ActiveRecord::Migration[6.0]
  def change
    add_index :product_attributes_names, :name, :unique => true
  end
end
