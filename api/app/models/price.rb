class Price < ApplicationRecord
  belongs_to :quality
  belongs_to :movie
  belongs_to :season
end
