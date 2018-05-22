source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bcrypt"
gem "bootstrap-kaminari-views"
gem "bootstrap-sass", "3.3.7"
gem "carrierwave"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "devise"
gem "devise-i18n"
gem "faker"
gem "figaro"
gem "font-awesome-rails"
gem "jbuilder", "~> 2.5"
gem "jquery-rails", "~> 4.3", ">= 4.3.1"
gem "jquery-ui-rails", "~> 5.0"
gem "kaminari"
gem "mysql2"
gem "omniauth"
gem "omniauth-facebook"
gem "paperclip"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.6"
gem "ransack", "~> 1.7"
gem "ratyrate"
gem "sass-rails", "~> 5.0"
gem "sidekiq"
gem "social-share-button"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "whenever"

group :development, :test do
  gem "rubocop", require: false
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
end

group :development do
  gem "pry-rails"
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
