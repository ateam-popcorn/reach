class Candidate < ActiveRecord::Base
  belongs_to :research
  belongs_to :user
end
