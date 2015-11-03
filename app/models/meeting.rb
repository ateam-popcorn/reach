class Meeting < ActiveRecord::Base
  belongs_to :research
  has_many :participants
  has_many :users, through: :participants
  has_many :notes
  has_one :room, dependent: :destroy
end
