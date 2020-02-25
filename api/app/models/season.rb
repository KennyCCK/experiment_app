class Season < ApplicationRecord
  belongs_to :movie
  has_many :episodes
end
