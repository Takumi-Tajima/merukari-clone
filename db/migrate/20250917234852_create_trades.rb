class CreateTrades < ActiveRecord::Migration[8.0]
  def change
    create_table :trades do |t|
      t.references :buyer, null: false, foreign_key: { to_table: :users }
      t.references :seller, null: false, foreign_key: { to_table: :users }
      t.references :product, null: false, foreign_key: true, index: { unique: true }
      t.string :buyer_name, null: false
      t.string :buyer_zipcode, null: false
      t.text :buyer_address, null: false
      t.string :buyer_phone_number, null: false
      t.integer :selling_fee, null: false
      t.integer :product_price, null: false
      t.datetime :confirmed_at, null: false
      t.datetime :shipping_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end
