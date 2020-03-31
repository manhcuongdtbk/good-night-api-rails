require "rails_helper"

RSpec.describe Sleep, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:operation_start).class_name("Operation").with_foreign_key("operation_start_id") }
  it {
    is_expected.to belong_to(:operation_stop).class_name("Operation").with_foreign_key("operation_stop_id").optional
  }
end
