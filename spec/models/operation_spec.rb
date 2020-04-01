require "rails_helper"

RSpec.describe Operation, type: :model do
  it { is_expected.to belong_to(:sleep) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to define_enum_for(:operation_type).with_values(stop: 0, start: 1) }
end
