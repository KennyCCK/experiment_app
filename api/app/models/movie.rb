class Movie < ApplicationRecord
  belongs_to :genre
  has_many :seasons
  has_many :videos
end
