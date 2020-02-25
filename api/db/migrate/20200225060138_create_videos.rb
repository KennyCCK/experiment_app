class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :filename, limit: 191
      t.string :ext, limit: 10
      t.bigint :size
      t.references :quality, foreign_key: true
      t.decimal :duration_mins, precision: 10, scale: 2
      t.string :storage_path, limit: 191
      t.references :movie, foreign_key: true
      t.references :season, foreign_key: true
      t.references :episode, foreign_key: true

      t.timestamps
    end
  end
end
