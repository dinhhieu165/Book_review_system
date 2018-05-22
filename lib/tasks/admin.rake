require "faker"
namespace :db do
  desc "admin data"
  task admin: :environment do
    %w[db:drop db:create db:migrate].each do |task|
      Rake::Task[task].invoke
    end
    puts "You will be prompted to create data for project"


    14.times do
      Category.create do |category|
        category.name = Faker::HarryPotter.location
      end
    end

    Settings.users.each do |user|
      User.create name: user.name, email: user.email, password: user.password,
        password_confirmation: user.password_confirmation, activated: user.activated,
        admin: user.role
    end

    User.create(
      :name => "Admin",
      :email => "admin@gmail.com",
      :password => "123123",
      :password_confirmation => "123123",
      :admin => 1)

    20.times do
      User.create do |user|
        user.name = Faker::Name.name
        user.email = Faker::Internet.email
        user.password = "123456"
        user.password_confirmation = "123456"
        user.admin = 0
        user.activated = true
      end
    end
  end
end
