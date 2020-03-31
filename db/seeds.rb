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
# rubocop:enable Rails/Output
