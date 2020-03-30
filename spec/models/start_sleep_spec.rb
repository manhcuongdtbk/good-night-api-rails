require "rails_helper"

RSpec.describe StartSleep, type: :model do
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:started_at) }
end
