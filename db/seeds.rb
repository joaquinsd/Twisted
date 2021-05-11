# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

pics = %w[ https://images2-mega.cdn.mdstrm.com/etcetera/2018/01/11/5290_1_5a57605f3e92c.jpg?d=500x500
https://images2-mega.cdn.mdstrm.com/etcetera/2017/09/13/4425_2_59b988c2e5d65.jpg?d=500x500
https://pbs.twimg.com/profile_images/2594744424/image.jpg
https://i1.sndcdn.com/artworks-000526465941-dx4yii-t500x500.jpg
https://i1.sndcdn.com/avatars-000231745424-ysagc7-t500x500.jpg
 https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy2mGo6Y1G9bSrnXcBqtlElM6QjyuitqkUdDJ-zyLOoo1i4GmXfuFQhmhp62j_mFiSomw&usqp=CAU
 https://i1.sndcdn.com/artworks-000087879475-sbbjd7-t500x500.jpg
 https://i1.sndcdn.com/artworks-000052366663-oe671e-t500x500.jpg
 https://static.wikia.nocookie.net/espokemon/images/b/b3/La_historia_del_Charizard_de_Ash_Pok%C3%A9mon_Negro_y_Blanco_Aventuras_en_Teselia_y_m%C3%A1s_all%C3%A1/revision/latest?cb=20200801100911'
 https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSofNHyVjj1crlaaveg6T0JY6f1QnLT1dh7AvV0nknXju2M7Qmh5vhoUmV31sZV5QAVv_8&usqp=CAU]

20.times do |i|
  pp = pics[rand(0..9)]
  u = User.create(email: Faker::Internet.unique.email, username: Faker::Games::Pokemon.name, password: Faker::Internet.password, profile_pic: pp)
end
10.times do |i|
  name = Faker::Games::Pokemon.name
  location = Faker::Games::Pokemon.location
  move = Faker::Games::Pokemon.move
  quote = rand(1..4)
  content = case quote
  when 1 then "Look a #{name} used #{move}"
  when 2 then "I'm from #{location}"
  when 3 then "I love my #{name}"
  when 4 then "Is #{move} supereffective against #{name}?"
end


  Tweet.create(user_id: rand(0..19), content: content)
end

User.all.each do |u|
  Tweet.all.each do |t|
    Like.create(tweet: t, user: u) if rand(1..5) == 1
  end
end
50.times do
  if rand(1..4) == 4 && Tweet.count > 0
    tweet_id = rand(Tweet.first.id..Tweet.last.id)
    user_id = rand(User.first.id .. User.last.id)
    Tweet.find(tweet_id).retweet(User.find(user_id))
  end
end

