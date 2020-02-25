class CreateUserLibraries < ActiveRecord::Migration[5.2]
  def change
    create_table :user_libraries do |t|
      t.references :user, foreign_key: true
      t.references :purchase_transaction, foreign_key: true
      t.references :movie, foreign_key: true
      t.references :season, foreign_key: true
      t.datetime :expiry_dt

      t.timestamps
    end
  end
end
