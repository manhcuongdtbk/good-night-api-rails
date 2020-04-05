source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.5"

gem "bootsnap", ">= 1.4.2", require: false
gem "hiredis"
gem "mysql2", ">= 0.4.4"
gem "puma", "~> 4.1"
gem "rack-cors"
gem "rails", "~> 6.0.2", ">= 6.0.2.2"
gem "redis"
gem "sidekiq"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails", "~> 4.0.0"
end

group :development do
  gem "brakeman"
  gem "bullet"
  gem "fasterer"
  gem "i18n-tasks", "~> 0.9.31"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rails_best_practices"
  gem "rubocop", "~> 0.80.1", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "database_cleaner-active_record"
  gem "shoulda-matchers"
  gem "simplecov", require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
