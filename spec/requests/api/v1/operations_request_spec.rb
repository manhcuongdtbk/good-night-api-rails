require "rails_helper"

RSpec.describe "Api::V1::Operations", type: :request do
  let!(:user1) { create(:user) }

  describe "GET /api/v1/users/:user_id/operations" do
    before do
      create(:operation, operation_type: "start", operated_at: 10.hours.ago, user: user1)
      create(:operation, operation_type: "stop", operated_at: 5.hours.ago, user: user1)
      get "/api/v1/users/#{user1.id}/operations"
    end

    it "returns all clocked-in times of this user order by created time with status 200" do
      expect(parsed_body.size).to eq(2)
      expect(parsed_body).to eq(Operation.all.order(created_at: :desc).as_json(only: [:id, :operation_type,
                                                                                      :operated_at, :created_at]))
    end

    specify { expect(response).to have_http_status(:ok) }
  end

  describe "POST /api/v1/users/:user_id/operations" do
    context "when user has no previous operation" do
      before { post "/api/v1/users/#{user1.id}/operations", params: params }

      context "with operation_type is start, operated_at is a valid datetime" do
        let(:params) { { operation_type: "start", operated_at: 10.hours.ago } }

        it "returns an object contains all request attributes" do
          operation = Operation.last

          expect(parsed_body.size).to eq(7)
          expect(parsed_body).to eq(operation.as_json)
        end

        specify { expect(response).to have_http_status(:created) }
      end

      context "with operation_type is stop" do
        let(:params) { { operation_type: "stop", operated_at: 10.hours.ago } }

        specify { expect(response.body).to match(/Validation failed: Operation type is invalid/) }
        specify { expect(response).to have_http_status(:unprocessable_entity) }
      end
    end

    context "when user has previous operation" do
      context "when last operation's operation_type is start" do
        context "with operation_type is stop" do
          before do
            create(:operation, operation_type: "start", operated_at: 10.hours.ago, user: user1)
            post "/api/v1/users/#{user1.id}/operations", params: params
          end

          let(:params) { { operation_type: "stop", operated_at: 5.hours.ago } }

          it "returns an object contains all request attributes" do
            operation = Operation.last

            expect(parsed_body.size).to eq(7)
            expect(parsed_body).to eq(operation.as_json)
          end
        end

        context "with operation_type is start" do
          before do
            create(:operation, operation_type: "start", operated_at: 10.hours.ago, user: user1)
            post "/api/v1/users/#{user1.id}/operations", params: params
          end

          let(:params) { { operation_type: "start", operated_at: 5.hours.ago } }

          specify { expect(response.body).to match(/Validation failed: Operation type is invalid/) }
          specify { expect(response).to have_http_status(:unprocessable_entity) }
        end
      end

      context "when last operation's operation_type is stop" do
        context "with operation_type is start" do
          before do
            create(:operation, operation_type: "start", operated_at: 10.hours.ago, user: user1)
            create(:operation, operation_type: "stop", operated_at: 6.hours.ago, user: user1)
            post "/api/v1/users/#{user1.id}/operations", params: params
          end

          let(:params) { { operation_type: "start", operated_at: 5.hours.ago } }

          it "returns an object contains all request attributes" do
            operation = Operation.last

            expect(parsed_body.size).to eq(7)
            expect(parsed_body).to eq(operation.as_json)
          end
        end

        context "with operation_type is stop" do
          before do
            create(:operation, operation_type: "start", operated_at: 10.hours.ago, user: user1)
            create(:operation, operation_type: "stop", operated_at: 6.hours.ago, user: user1)
            post "/api/v1/users/#{user1.id}/operations", params: params
          end

          let(:params) { { operation_type: "stop", operated_at: 5.hours.ago } }

          specify { expect(response.body).to match(/Validation failed: Operation type is invalid/) }
          specify { expect(response).to have_http_status(:unprocessable_entity) }
        end
      end

      context "when operated_at is before last's operation operated_at" do
        before do
          create(:operation, operation_type: "start", operated_at: 10.hours.ago, user: user1)
          post "/api/v1/users/#{user1.id}/operations", params: params
        end

        let(:params) { { operation_type: "stop", operated_at: 20.hours.ago } }

        specify { expect(response.body).to match(/Validation failed: Operated at is invalid/) }
        specify { expect(response).to have_http_status(:unprocessable_entity) }
      end
    end

    context "with operated_at is not a datetime" do
      before { post "/api/v1/users/#{user1.id}/operations", params: params }

      let(:params) { { operation_type: "start", operated_at: "tripla" } }

      specify { expect(response.body).to match(/Validation failed: Operated at can't be blank/) }
      specify { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context "with operated_at is after current_time" do
      before { post "/api/v1/users/#{user1.id}/operations", params: params }

      let(:params) { { operation_type: "start", operated_at: 1.hour.from_now } }

      specify { expect(response.body).to match(/Validation failed: Operated at is invalid/) }
      specify { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context "without operation_type" do
      before { post "/api/v1/users/#{user1.id}/operations", params: params }

      let(:params) { { operated_at: 5.hours.ago } }

      specify { expect(response.body).to match(/Validation failed: Operation type is invalid/) }
      specify { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context "without operated_at" do
      before { post "/api/v1/users/#{user1.id}/operations", params: params }

      let(:params) { { operation_type: "start" } }

      specify { expect(response.body).to match(/Validation failed: Operated at can't be blank/) }
      specify { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end
end
