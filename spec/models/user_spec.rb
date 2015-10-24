require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new }

  it { is_expected.to respond_to(:meetings) }
  it { is_expected.to respond_to(:user_meetings) }
  it { is_expected.to respond_to(:notes) }
end