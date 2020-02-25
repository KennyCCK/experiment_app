class UserLibrary < ApplicationRecord
  belongs_to :user
  belongs_to :purchase_transaction
  belongs_to :movie
  belongs_to :season, required: false
end
