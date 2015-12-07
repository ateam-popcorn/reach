require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { is_expected.to respond_to(:user) }
end
