FactoryBot.define do
  factory :operation do
    operated_at { 10.hours.ago }
    user { create(:user) }
  end
end
