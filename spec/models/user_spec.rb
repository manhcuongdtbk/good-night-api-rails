require "rails_helper"

RSpec.describe User, type: :model do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  it { is_expected.to have_many(:sleeps).dependent(:destroy) }
  it { is_expected.to have_many(:start_sleeps).dependent(:destroy) }
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

  it "follow and unfollow a user" do
    expect(user1.following.include?(user2)).to(be_falsey)
    user1.follow(user2)
    expect(user1.following.include?(user2)).to(be_truthy)
    expect(user2.followers.include?(user1)).to(be_truthy)
    user1.unfollow(user2)
    expect(user1.following.include?(user2)).to(be_falsey)
  end
end
