require 'rails_helper'

RSpec.describe Question, type: :model do
  subject(:question) { Question.new }

  it { is_expected.to respond_to{:research} }
  it { is_expected.to respond_to{:text} }
  it { is_expected.to respond_to{:pass_answer} }

end
