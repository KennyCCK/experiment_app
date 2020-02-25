class Video < ApplicationRecord
  belongs_to :quality
  belongs_to :movie
  belongs_to :season, required: false
  belongs_to :episode, required: false
end
