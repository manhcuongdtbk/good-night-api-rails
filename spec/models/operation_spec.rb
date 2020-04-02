require "rails_helper"

RSpec.describe Operation, type: :model do
  it { is_expected.to belong_to(:sleep) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to define_enum_for(:operation_type).with_values(stop: 0, start: 1) }

  context "when all attributes are valid except for redundant sleep_id" do
    context "when operation is created on Operation model" do
      let(:operation) { build(:operation, operation_type: "start", sleep_id: 1) }

      it "returns error message for sleep" do
        expect(operation).not_to be_valid
        expect(operation.errors.messages.count).to eq(2)
        expect(operation.errors.messages[:sleep]).to eq([I18n.t("errors.messages.required")])
        expect(operation.errors.messages[:sleep_id]).to eq([I18n.t("activerecord.errors.messages.redundant")])
      end
    end

    context "when operation is created through Sleep model's association" do
      let(:sleep) { create(:sleep) }

      it "returns error message for sleep" do
        operation_start = sleep.build_operation_start(operation_type: "start", operated_at: 10.hours.ago,
                                                      user: sleep.user)
        operation_stop = sleep.build_operation_start(operation_type: "stop", operated_at: 10.hours.ago,
                                                     user: sleep.user)

        # puts operation_start.errors.messages
        expect(operation_start).not_to be_valid
        expect(operation_start.errors.messages.count).to eq(1)
        expect(operation_start.errors.messages[:sleep_id]).to eq([I18n.t("activerecord.errors.messages.redundant")])

        expect(operation_stop).not_to be_valid
        expect(operation_stop.errors.messages.count).to eq(1)
        expect(operation_stop.errors.messages[:sleep_id]).to eq([I18n.t("activerecord.errors.messages.redundant")])
      end
    end
  end
end
