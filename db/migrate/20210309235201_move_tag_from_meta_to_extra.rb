class MoveTagFromMetaToExtra < ActiveRecord::Migration[6.0]
  def change
    remove_column :product_meta, :tag
    add_column :product_extras, :tag, :string
  end
end
