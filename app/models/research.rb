class Research < ActiveRecord::Base
  has_many :meetings
  has_many :questions
  has_many :candidates
  accepts_nested_attributes_for :questions
end
