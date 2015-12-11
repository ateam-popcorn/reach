require 'rails_helper'

RSpec.describe Candidate, type: :model do
  subject(:candidate) { Candidate.new }

  it { is_expected.to respond_to(:research) }
  it { is_expected.to respond_to(:user) }
  it { is_expected.to respond_to(:status) }

end
