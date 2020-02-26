class UserLibrary < ApplicationRecord

  attr_accessor :remaining_time_seconds

  belongs_to :user
  belongs_to :purchase_transaction
  belongs_to :movie
  belongs_to :season, required: false

  def calc_remaining_time
    remaining = ((expiry_dt - Time.now)).to_i
    @remaining_time_seconds = remaining > 0 ? remaining : 0
  end
end
