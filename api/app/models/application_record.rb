class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def set_access_key
    self.access_key ||= SecureRandom.uuid
  end

end
