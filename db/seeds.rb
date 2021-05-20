# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

# For creating users
170.times do
  begin
    name = Faker::Games::Pokemon.name
    if name == 'Nidoran'
      pp = "https://images.wikidexcdn.net/mwuploads/wikidex/thumb/f/f8/latest/20200428203046/#{name}♂.png/250px-#{name}♂.png"
    else
      pp = "https://images.wikidexcdn.net/mwuploads/wikidex/thumb/f/f8/latest/20200428203046/#{name}.png/250px-#{name}.png"
    end
    User.create(email: "#{name}@pokemon.com", username: name, password: Faker::Internet.password, profile_pic: pp)
  rescue ActiveRecord::RecordInvalid
    next
  end
end

# For creating Tweets
100.times do
  name = Faker::Games::Pokemon.name
  location = Faker::Games::Pokemon.location
  move = Faker::Games::Pokemon.move
  quote = rand(1..5)
  content = case quote
            when 1 then "Look a #{name} used #{move}"
            when 2 then "I'm from ##{location}"
            when 3 then "I love my #{name}!! ##{name}lovers"
            when 4 then "Is #{move} supereffective against #{name}?"
            when 5 then "Team Rocket stole a #{name} from that Trainer!!"
            end

  Tweet.create(user_id: rand(0..100), content: content)
end

# For liking Tweets
User.all.each do |u|
  Tweet.all.each do |t|
    Like.create(tweet: t, user: u) if rand(1..5) == 1
  end
end

# For retweeting Tweets
50.times do
  if rand(1..4) == 4 && Tweet.count > 0
    tweet_id = rand(Tweet.first.id..Tweet.last.id)
    user_id = rand(User.first.id .. User.last.id)
    Tweet.find(tweet_id).retweet(User.find(user_id))
  end
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?