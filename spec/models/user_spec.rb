require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:sleeps).dependent(:destroy) }
  it {
    is_expected.to have_many(:active_relationships).class_name("Relationship").with_foreign_key("follower_id")
                                                   .dependent(:destroy)
  }
  it {
    is_expected.to have_many(:passive_relationships).class_name("Relationship").with_foreign_key("followed_id")
                                                    .dependent(:destroy)
  }
  it { is_expected.to have_many(:following).through(:active_relationships).source(:followed) }
  it { is_expected.to have_many(:followers).through(:passive_relationships).source(:follower) }

  it { is_expected.to validate_presence_of(:name) }
end
