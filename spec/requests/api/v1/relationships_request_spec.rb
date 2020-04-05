require "rails_helper"

RSpec.describe "Api::V1::Relationships", type: :request do
  let!(:user1) { create(:user) }

  describe "POST /api/v1/users/:user_id/follow" do
    context "when request attributes are valid" do
      context "with an existed followed_id that this user have not followed before" do
        let(:user2) { create(:user) }

        before { post "/api/v1/users/#{user1.id}/follow", params: { followed_id: user2.id } }

        it "returns a successfully created relationship and status 200" do
          expect(response.body).to match(
            /#{I18n.t("api.v1.relationships.create.follow_successfully", followed_id: user2.id)}/
          )
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context "when request attributes are invalid" do
      context "with a not existed followed_id" do
        let(:followed_id) { 0 }

        before { post "/api/v1/users/#{user1.id}/follow", params: { followed_id: followed_id } }

        it "returns a not found user error message with status 404" do
          expect(response.body).to match(/Couldn't find User with 'id'=#{followed_id}/)
          expect(response).to have_http_status(:not_found)
        end
      end

      context "with an already followed followed_id" do
        let(:user3) { create(:user) }

        before do
          user1.follow(user3)
          post "/api/v1/users/#{user1.id}/follow", params: { followed_id: user3.id }
        end

        it "returns a duplicate follower_id-followed_id for key error message and status 409" do
          expect(response.body).to match(/Mysql2::Error: Duplicate entry '#{user1.id}-#{user3.id}' for key/)
          expect(response).to have_http_status(:conflict)
        end
      end

      context "with followed_id is user_id" do
        before do
          user1.follow(user1)
          post "/api/v1/users/#{user1.id}/follow", params: { followed_id: user1.id }
        end

        it "returns a duplicate follower_id-followed_id for key error message and status 409" do
          expect(response.body).to match(/Mysql2::Error: Duplicate entry '#{user1.id}-#{user1.id}' for key/)
          expect(response).to have_http_status(:conflict)
        end
      end
    end
  end

  describe "DELETE /api/v1/users/:user_id/unfollow" do
    let(:user4) { create(:user) }

    before do
      user1.follow(user4)
      delete "/api/v1/users/#{user1.id}/unfollow", params: params
    end

    context "when request attributes is valid" do
      let(:params) { { followed_id: user4.id } }

      it "returns a successfully destroyed relationship and status 200" do
        expect(response.body).to match(
          /#{I18n.t("api.v1.relationships.destroy.unfollow_successfully", followed_id: user4.id)}/
        )
        expect(response).to have_http_status(:ok)
      end
    end

    context "when request attributes is invalid" do
      context "with a not existed followed_id" do
        let(:params) { { followed_id: 0 } }

        it "returns a not found relationship error message and status 404" do
          expect(response.body).to match(/Couldn't find Relationship/)
          expect(response).to have_http_status(:not_found)
        end
      end

      context "with followed_id is user_id" do
        let(:params) { { followed_id: user1.id } }

        it "returns a not found relationship error message and status 404" do
          expect(response.body).to match(/Couldn't find Relationship/)
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
