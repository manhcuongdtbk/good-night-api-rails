FactoryBot.define do
  factory :stop_sleep do
    started_at { 10.hours.ago }
    stopped_at { Time.zone.now }
    duration { stopped_at - started_at }
    user { create(:user) }
  end
end
