class Profile < ActiveRecord::Base
  belongs_to :user
  before_save :set_age_from_birthday

  private

  def set_age_from_birthday
    self.age = (Time.zone.today - birthday.to_date).to_i / 365
  end
end
