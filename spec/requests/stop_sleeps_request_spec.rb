require "rails_helper"

RSpec.describe "StopSleeps", type: :request do
  let!(:user) { create(:user) }

  describe "POST /api/v1/users/:user_id/stop_sleeps" do
    before { post "/api/v1/users/#{user.id}/stop_sleeps", params: params }

    context "when request attributes is valid" do
      let(:params) { { started_at: 10.hours.ago, stopped_at: Time.zone.now } }

      specify { expect(response.body).to match(/#{I18n.t("controllers.stop_sleeps.create.clocked_in_successfully")}/) }
      specify { expect(response).to have_http_status(:ok) }
    end

    context "when request attributes is invalid" do
      context "with started_at, stopped_at" do
        let(:params) { { started_at: "tripla", stopped_at: Time.zone.now } }

        specify { expect(response.body).to match(/Validation failed: Started at can't be blank/) }
        specify { expect(response).to have_http_status(:unprocessable_entity) }
      end

      context "without started_at" do
        let(:params) { { stopped_at: Time.zone.now } }

        specify { expect(response.body).to match(/Validation failed: Started at can't be blank/) }
        specify { expect(response).to have_http_status(:unprocessable_entity) }
      end

      context "without stopped_at" do
        let(:params) { { started_at: 10.hours.ago } }

        specify { expect(response.body).to match(/Validation failed: Stopped at can't be blank/) }
        specify { expect(response).to have_http_status(:unprocessable_entity) }
      end
    end
  end
end
