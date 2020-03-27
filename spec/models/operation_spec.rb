require "rails_helper"

RSpec.describe Operation, type: :model do
  it { is_expected.to belong_to(:sleep) }

  it { is_expected.to validate_presence_of(:operation_type) }
  it { is_expected.to validate_presence_of(:operated_at) }
  it { is_expected.to validate_presence_of(:sleep_id) }
end
