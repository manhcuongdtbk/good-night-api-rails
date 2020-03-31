FactoryBot.define do
  factory :sleep do
    user { create(:user) }
  end
end
