# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
10.times do
  user = User.create!(
    username: Faker::JapaneseMedia::StudioGhibli.unique.character,
    email: Faker::Internet.email,
    password: 'foobar',
    password_confirmation: 'foobar',
  )
  puts "\"#{user.username}\" has created!"
end  

20.times do |index|
  Tweet.create(
      user: User.offset(rand(User.count)).first,
      body: "本文#{index}"
  )
end