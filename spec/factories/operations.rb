FactoryBot.define do
  factory :operation do
    operated_at { 10.hours.ago }
  end
end
