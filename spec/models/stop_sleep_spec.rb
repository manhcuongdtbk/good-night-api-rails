require "rails_helper"

RSpec.describe StopSleep, type: :model do
  it { is_expected.to validate_presence_of(:stopped_at) }
  it { is_expected.to validate_presence_of(:duration) }
  it { is_expected.to validate_numericality_of(:duration).is_greater_than(0) }
end
