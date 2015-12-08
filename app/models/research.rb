class Research < ActiveRecord::Base
  has_many :meetings
  has_many :questions
end
