require "rails_helper"

RSpec.describe "StartSleeps", type: :request do
  let!(:user) { create(:user) }

  describe "POST /api/v1/users/:user_id/start_sleeps" do
    before { post "/api/v1/users/#{user.id}/start_sleeps", params: params }

    context "when request attributes is valid" do
      let(:params) { { started_at: Time.zone.now } }

      specify { expect(response.body).to match(/#{I18n.t("controllers.start_sleeps.create.clocked_in_successfully")}/) }
      specify { expect(response).to have_http_status(:ok) }
    end

    context "when request attributes is invalid" do
      let(:params) { { started_at: "tripla" } }

      specify { expect(response.body).to match(/Validation failed: Started at can't be blank/) }
      specify { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end
end
