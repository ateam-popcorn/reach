class Room < ActiveRecord::Base
  belongs_to :meeting

  after_initialize :set_token

  def set_token
    self.token = SecureRandom.urlsafe_base64
  end
end
