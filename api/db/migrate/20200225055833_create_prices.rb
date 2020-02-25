class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.decimal :price_usd, precision: 10, scale: 2
      t.references :quality, foreign_key: true
      t.references :movie, foreign_key: true
      t.references :season, foreign_key: true

      t.timestamps
    end
  end
end
