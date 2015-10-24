require 'rails_helper'

RSpec.describe UserMeeting, type: :model do
  subject(:user_meeting) { UserMeeting.new }

  it { is_expected.to respond_to(:user) }
  it { is_expected.to respond_to(:meeting) }
end
