FactoryBot.define do
  factory :start_sleep do
    started_at { 10.hours.ago }
    user { create(:user) }
  end
end
