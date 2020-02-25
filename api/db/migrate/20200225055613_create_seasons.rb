class CreateSeasons < ActiveRecord::Migration[5.2]
  def change
    create_table :seasons do |t|
      t.references :movie, foreign_key: true
      t.integer :season_num
      t.string :season_title, limit: 191
      t.text :season_synopsis

      t.timestamps
    end
  end
end
