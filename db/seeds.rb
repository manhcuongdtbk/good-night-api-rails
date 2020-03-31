# rubocop:disable Rails/Output
puts "Importing users"
ids = (1..100).to_a
users = ids.map do
  current_time = Time.zone.now
  { name: Faker::Name.name, created_at: current_time, updated_at: current_time }
end
User.insert_all!(users)

puts "Importing relationships"
ids.each do |follower_id|
  user = User.find(follower_id)
  user.following_ids += ids.sample(10)
end

puts "Importing start sleeps"
start_sleeps = ids.map do |user_id|
  current_time = Time.zone.now
  { type: "StartSleep", started_at: 10.hours.ago, user_id: user_id, created_at: current_time, updated_at: current_time }
end
StartSleep.insert_all!(start_sleeps)

puts "Importing stop sleeps"
stop_sleeps = ids.map do |user_id|
  current_time = Time.zone.now
  { type: "StopSleep", started_at: 10.hours.ago, stopped_at: Time.zone.now, user_id: user_id, created_at: current_time,
    updated_at: current_time }
end
StopSleep.insert_all!(stop_sleeps)
# rubocop:enable Rails/Output
