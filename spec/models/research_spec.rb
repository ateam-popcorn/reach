require 'rails_helper'

RSpec.describe Research, type: :model do
  subject(:research) { Research.new }

  it { is_expected.to respond_to(:meetings) }
  it { is_expected.to respond_to(:questions) }
end
