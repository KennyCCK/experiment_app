# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_25_142000) do

  create_table "episodes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "season_id"
    t.integer "episode_num"
    t.string "episode_title", limit: 191
    t.text "episode_plot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_episodes_on_season_id"
  end

  create_table "genres", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", limit: 191
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "movie_name", limit: 191
    t.text "movie_desc"
    t.bigint "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_movies_on_genre_id"
  end

  create_table "prices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.decimal "price_usd", precision: 10, scale: 2
    t.bigint "quality_id"
    t.bigint "movie_id"
    t.bigint "season_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "price_type", limit: 20
    t.integer "valid_days"
    t.index ["movie_id"], name: "index_prices_on_movie_id"
    t.index ["quality_id"], name: "index_prices_on_quality_id"
    t.index ["season_id"], name: "index_prices_on_season_id"
  end

  create_table "purchase_transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.string "purchase_type", limit: 20
    t.string "purchase_quality", limit: 100
    t.decimal "purchase_price", precision: 10, scale: 2
    t.bigint "movie_id"
    t.bigint "season_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_purchase_transactions_on_movie_id"
    t.index ["season_id"], name: "index_purchase_transactions_on_season_id"
    t.index ["user_id"], name: "index_purchase_transactions_on_user_id"
  end

  create_table "qualities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", limit: 191
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seasons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "movie_id"
    t.integer "season_num"
    t.string "season_title", limit: 191
    t.text "season_synopsis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_seasons_on_movie_id"
  end

  create_table "user_libraries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "purchase_transaction_id"
    t.bigint "movie_id"
    t.bigint "season_id"
    t.datetime "expiry_dt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_user_libraries_on_movie_id"
    t.index ["purchase_transaction_id"], name: "index_user_libraries_on_purchase_transaction_id"
    t.index ["season_id"], name: "index_user_libraries_on_season_id"
    t.index ["user_id"], name: "index_user_libraries_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", limit: 191
    t.string "email", limit: 191
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "videos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "filename", limit: 191
    t.string "ext", limit: 10
    t.bigint "size"
    t.bigint "quality_id"
    t.decimal "duration_mins", precision: 10, scale: 2
    t.string "storage_path", limit: 191
    t.bigint "movie_id"
    t.bigint "season_id"
    t.bigint "episode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_videos_on_episode_id"
    t.index ["movie_id"], name: "index_videos_on_movie_id"
    t.index ["quality_id"], name: "index_videos_on_quality_id"
    t.index ["season_id"], name: "index_videos_on_season_id"
  end

  add_foreign_key "episodes", "seasons"
  add_foreign_key "movies", "genres"
  add_foreign_key "prices", "movies"
  add_foreign_key "prices", "qualities"
  add_foreign_key "prices", "seasons"
  add_foreign_key "purchase_transactions", "movies"
  add_foreign_key "purchase_transactions", "seasons"
  add_foreign_key "purchase_transactions", "users"
  add_foreign_key "seasons", "movies"
  add_foreign_key "user_libraries", "movies"
  add_foreign_key "user_libraries", "purchase_transactions"
  add_foreign_key "user_libraries", "seasons"
  add_foreign_key "user_libraries", "users"
  add_foreign_key "videos", "episodes"
  add_foreign_key "videos", "movies"
  add_foreign_key "videos", "qualities"
  add_foreign_key "videos", "seasons"
end
