# rubocop:disable Rails/Output
puts "Importing users"
ids = (1..100).to_a
users = ids.map do
  current_time = Time.zone.now
  { name: Faker::Name.name, created_at: current_time, updated_at: current_time }
end
User.insert_all!(users)

puts "Importing relationships"
relationships = []
ids.each do |follower_id|
  followed_ids = ids.sample(10)
  current_time = Time.zone.now
  followed_ids.each do |followed_id|
    relationships << { follower_id: follower_id, followed_id: followed_id, created_at: current_time,
                       updated_at: current_time }
  end
end
Relationship.insert_all!(relationships)

puts "Importing operations"
operations = ids.map do |id|
  current_time = Time.zone.now
  { operated_at: id.hours.ago, created_at: current_time, updated_at: current_time }
end
Operation.insert_all!(operations)
# rubocop:enable Rails/Output
