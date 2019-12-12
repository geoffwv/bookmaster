2.times do
  user = User.create(name: Faker::FunnyName.name, email:Faker::Internet.email)
  3.times do
    user.books.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, author: Faker::Name.first_name)
  end
end