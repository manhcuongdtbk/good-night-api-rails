require "rails_helper"

RSpec.describe Relationship, type: :model do
  it { is_expected.to belong_to(:follower).class_name("User") }
  it { is_expected.to belong_to(:followed).class_name("User") }

  it { is_expected.to validate_presence_of(:follower_id) }
  it { is_expected.to validate_presence_of(:followed_id) }
end
