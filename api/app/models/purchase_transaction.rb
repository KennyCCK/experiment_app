class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  belongs_to :season
end
