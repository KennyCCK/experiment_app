class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.references :season, foreign_key: true
      t.integer :episode_num
      t.string :episode_title, limit: 191
      t.text :episode_plot

      t.timestamps
    end
  end
end
