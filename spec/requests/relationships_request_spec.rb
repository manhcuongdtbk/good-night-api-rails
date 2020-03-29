require "rails_helper"

RSpec.describe "Relationships", type: :request do
  let!(:user1) { create(:user) }

  describe "POST /api/v1/users/:user_id/follow" do
    before { post "/api/v1/users/#{user1.id}/follow", params: params }

    context "when request attributes is valid" do
      let(:user2) { create(:user) }
      let(:params) { { followed_id: user2.id } }
      specify { expect(response).to have_http_status(:ok) }
      specify { expect(response.body).to match(/Follow user with id #{user2.id} successfully/) }
    end

    context "when request attributes is invalid" do
      let(:params) { { followed_id: 0 } }
      specify { expect(response).to have_http_status(:not_found) }
      specify { expect(response.body).to match(/Couldn't find User with 'id'=#{params[:followed_id]}/) }
    end
  end

  describe "DELETE /api/v1/users/:user_id/unfollow" do
    let!(:user2) { create(:user) }

    before do
      user1.follow(user2)
      delete "/api/v1/users/#{user1.id}/unfollow", params: params
    end

    context "when request attributes is valid" do
      let(:params) { { followed_id: user2.id } }
      specify { expect(response).to have_http_status(:ok) }
      specify { expect(response.body).to match(/Unfollow user with id #{user2.id} successfully/) }
    end

    context "when request attributes is invalid" do
      let(:params) { { followed_id: 0 } }
      specify { expect(response).to have_http_status(:not_found) }
      specify { expect(response.body).to match(/Couldn't find Relationship/) }
    end
  end
end
