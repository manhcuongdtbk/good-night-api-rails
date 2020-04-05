require "rails_helper"

RSpec.describe "Api::V1::FollowingSleeps", type: :request do
  let!(:user1) { create(:user) }

  describe "GET /api/v1/users/:user_id/following_sleeps" do
    before do
      user2 = create(:user)
      user1.follow(user2)
      create(:operation, operation_type: "start", operated_at: 10.hours.ago, user: user1)
      create(:operation, operation_type: "stop", operated_at: 5.hours.ago, user: user1)
      get "/api/v1/users/#{user1.id}/operations"
    end

    it "returns all following sleeps of this user order by the length of those sleeps with status 200" do
      expect(response).to have_http_status(:ok)
    end
  end
end
