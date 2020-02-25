class Video < ApplicationRecord
  belongs_to :quality
  belongs_to :movie
  belongs_to :season
  belongs_to :episode
end
