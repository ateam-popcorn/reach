require 'rails_helper'

RSpec.describe Meeting, type: :model do
  subject(:meeting) { Meeting.new }

  it { is_expected.to respond_to(:research) }
  it { is_expected.to respond_to(:users) }
  it { is_expected.to respond_to(:user_meetings) }
  it { is_expected.to respond_to(:notes) }
end
