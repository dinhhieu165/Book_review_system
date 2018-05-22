User.create name: "admin",
            email: "admin@gmail.com",
            address: "Ha Noi",
            phone: "0988888888",
            password: "123123",
            password_confirmation: "123123",
            admin: 1
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  address = "Ha Noi #{n}"
  password = "password"
  phone = "0977373635"
  User.create!(name:  name,
               email: email,
               address: address,
               phone: phone,
               password:              password,
               password_confirmation: password,
               )
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
