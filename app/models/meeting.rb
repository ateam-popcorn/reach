class Meeting < ActiveRecord::Base
  belongs_to :research
  has_many :users
  has_many :user_meetings
  has_many :notes
end
