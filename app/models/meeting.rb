class Meeting < ActiveRecord::Base
  belongs_to :research
  has_many :participants
  has_many :users, through: :participants
  has_many :notes
end
