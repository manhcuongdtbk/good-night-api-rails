user_ids = (1..100).to_a
users = user_ids.map do
  current_time = Time.zone.now
  { name: Faker::Name.name, created_at: current_time, updated_at: current_time }
end
User.insert_all!(users)

user_ids.each do |follower_id|
  user = User.find(follower_id)
  user.following_ids += user_ids.sample(10)
end
