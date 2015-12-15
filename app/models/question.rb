class Question < ActiveRecord::Base
  belongs_to :research

  attr_accessor :answer
end
