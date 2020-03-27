require "rails_helper"

RSpec.describe Sleep, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:operations).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:user_id) }
end
