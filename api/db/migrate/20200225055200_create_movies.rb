class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :movie_name, limit: 191
      t.text :movie_desc
      t.references :genre, foreign_key: true

      t.timestamps
    end
  end
end
