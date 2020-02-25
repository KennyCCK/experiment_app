class PurchaseTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  belongs_to :season, required: false
end
