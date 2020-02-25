class CreateQualities < ActiveRecord::Migration[5.2]
  def change
    create_table :qualities do |t|
      t.string :name, limit: 191

      t.timestamps
    end
  end
end
