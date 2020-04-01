require "rails_helper"

RSpec.describe "Relationships", type: :request do
  let!(:user1) { create(:user) }

  describe "POST /api/v1/users/:user_id/follow" do
    before { post "/api/v1/users/#{user1.id}/follow", params: params }

    context "when request attributes is valid" do
      let(:user2) { create(:user) }
      let(:params) { { followed_id: user2.id } }
      it do
        expect(response.body).to match(
          /#{I18n.t("api.v1.relationships.create.follow_successfully", followed_id: params[:followed_id])}/
        )
      end
      specify { expect(response).to have_http_status(:ok) }
    end

    context "when request attributes is invalid" do
      let(:params) { { followed_id: 0 } }
      specify { expect(response.body).to match(/Couldn't find User with 'id'=#{params[:followed_id]}/) }
      specify { expect(response).to have_http_status(:not_found) }
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
      it do
        expect(response.body).to match(
          /#{I18n.t("api.v1.relationships.destroy.unfollow_successfully", followed_id: user2.id)}/
        )
      end
      specify { expect(response).to have_http_status(:ok) }
    end

    context "when request attributes is invalid" do
      let(:params) { { followed_id: 0 } }
      specify { expect(response.body).to match(/Couldn't find Relationship/) }
      specify { expect(response).to have_http_status(:not_found) }
    end
  end
end
