FactoryBot.define do
  factory :sleep do
    operation_start_id { create(:operation) }
    user { create(:user) }
  end
end
