puts "Importing users"
4.times do
  User.create!(name: Faker::Name.name)
end

puts "Importing relationships"
User.first.follow(User.second)
User.second.follow(User.third)
User.third.follow(User.fourth)
User.fourth.follow(User.first)

puts "Importing sleeps"
counter = (1..1000).to_a.reverse
1.upto(4) do |user_id|
  counter.each do |n|
    Operation.create!(operation_type: "start", operated_at: n.days.ago, user_id: user_id)
    Operation.create!(operation_type: "stop", operated_at: n.days.ago + 2.hours, user_id: user_id)
  end
end
