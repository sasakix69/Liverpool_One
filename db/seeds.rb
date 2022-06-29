# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
10.times do
  user = User.create!(
    username: Faker::JapaneseMedia::StudioGhibli.character,
    email: Faker::Internet.email,
    password: 'foobar',
    password_confirmation: 'foobar'
  )
  puts "\"#{user.username}\" has created!"
end

40.times do |n|
  Tweet.create(
    user: User.offset(rand(User.count)).first,
    body: Faker::JapaneseMedia::StudioGhibli.quote
  )
end
