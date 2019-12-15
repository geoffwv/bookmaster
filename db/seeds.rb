2.times do
  user = User.create(name: Faker::FunnyName.name, email:Faker::Internet.email)
  3.times do
    user.books.create(title: Faker::Book.title, publisher: Faker::Book.publisher, author: Faker::Book.author, genre: Faker::Book.genre)
  end
end