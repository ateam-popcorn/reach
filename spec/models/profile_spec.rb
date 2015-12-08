require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject(:profile) { Profile.new }

  it { is_expected.to respond_to(:user) }
  it { is_expected.to respond_to(:sex) }
  it { is_expected.to respond_to(:birthday) }
  it { is_expected.to respond_to(:age) }
  it { is_expected.to respond_to(:prefecture) }
  it { is_expected.to respond_to(:job) }

  describe 'when before save' do
    before { Timecop.freeze(Time.local(2013, 2, 14)) }
    after { Timecop.return }

    subject(:profile) { Profile.create(birthday: Date.new(1993, 2, 14)) }

    it 'set a age from the birthday' do
      expect(profile.age).to eq(20)
    end
  end
end
