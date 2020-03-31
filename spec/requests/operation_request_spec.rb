require "rails_helper"

RSpec.describe "Operations", type: :request do
  let!(:user1) { create(:user) }

  describe "POST /api/v1/users/:user_id/operations" do
    before { post "/api/v1/users/#{user1.id}/operations", params: params }

    context "when request attributes are valid" do
      context "when operation_type is start" do
        let(:params) { { operation_type: "start", operated_at: 10.hours.ago } }

        it "returns an object contains all request attributes" do
          operation = Operation.first
          parsed_response = JSON.parse(response.body)

          expect(parsed_response.size).to eq(6)
          expect(parsed_response["id"]).to eq(operation.id)
          expect(parsed_response["operation_type"]).to eq(operation.operation_type)
          expect(parsed_response["operated_at"]).to eq(operation.operated_at.as_json)
          expect(parsed_response["sleep_id"]).to eq(operation.sleep_id)
          expect(parsed_response["created_at"]).to eq(operation.created_at.as_json)
          expect(parsed_response["updated_at"]).to eq(operation.updated_at.as_json)
        end

        specify { expect(response).to have_http_status(:created) }
      end

      # context "when operation_type is stop" do
      # end
    end

    # context "when request attributes are invalid" do
    #   context "with operation_type, operated_at" do
    #     context "with operation_type is invalid" do
    #     end

    #     context "with operated_at is invalid" do
    #     end
    #   end

    #   context "without operation_type" do
    #   end

    #   context "without operated_at" do
    #   end
    # end
  end
end
