require 'rails_helper'

RSpec.describe Note, type: :model do
  subject(:note) { Note.new }

  it { is_expected.to respond_to(:meeting) }
  it { is_expected.to respond_to(:user) }
end
