class AddTypeDaysToPrice < ActiveRecord::Migration[5.2]
  def change
    add_column :prices, :price_type, :string, limit: 20
    add_column :prices, :valid_days, :integer
  end
end
