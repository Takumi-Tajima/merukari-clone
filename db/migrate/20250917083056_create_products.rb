class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :name, null: false
      t.string :description, null: false
      t.integer :price, null: false
      t.boolean :sold, default: false, null: false

      t.timestamps
    end
  end
end
