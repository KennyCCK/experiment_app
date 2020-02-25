class CreatePurchaseTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_transactions do |t|
      t.references :user, foreign_key: true
      t.string :purchase_type, limit: 20
      t.string :purchase_quality, limit: 100
      t.decimal :purchase_price, precision: 10, scale: 2
      t.references :movie, foreign_key: true
      t.references :season, foreign_key: true

      t.timestamps
    end
  end
end
