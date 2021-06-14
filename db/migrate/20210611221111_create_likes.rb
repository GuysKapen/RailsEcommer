class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :user, polymorphic: true, null: false
      t.references :record, polymorphic: true, null: false

      t.timestamps
    end
  end
end
