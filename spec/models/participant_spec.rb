require 'rails_helper'

RSpec.describe Participant, type: :model do
  subject(:participant) { Participant.new }

  it { is_expected.to respond_to(:user) }
  it { is_expected.to respond_to(:meeting) }
end
