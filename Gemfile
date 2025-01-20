source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.0"

gem "bootsnap", require: false
gem "cancancan", "~> 3.4"
gem "carrierwave", ">= 3.0.0.beta", "< 4.0"
gem "carrierwave-ftp", "~> 0.4.1", require: "carrierwave/storage/sftp", :git => "https://github.com/agencia-w3/carrierwave-ftp"
gem "cssbundling-rails"
gem "devise", "~> 4.9", ">= 4.9.2"
gem "devise-i18n", "~> 1.11"
gem "email_validator"
gem "friendly_id", "~> 5.5"
gem "jsbundling-rails"
gem "meta-tags", "~> 2.18"
gem "pg", "~> 1.1"
gem "pg_search", "~> 2.3", ">= 2.3.6"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "rails_admin", "~> 3.1", ">= 3.1.2"
gem "recaptcha", "~> 5.14"
gem "redis", "~> 5.0", ">= 5.0.6"
gem "sassc-rails"
gem "sitemap_generator", "~> 6.3"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "whenever", require: false
gem 'youtube_rails'
gem 'audited'
gem 'diffy'
gem 'diff-lcs' 
gem 'streamio-ffmpeg'
group :development, :test do
  gem "better_errors"
  gem "binding_of_caller"
  gem "erb-formatter", "~> 0.4.3"
  gem "hotwire-livereload", "~> 1.2", ">= 1.2.3"
  gem "pry-byebug", "~> 3.10", ">= 3.10.1"
end

group :development do
  gem "web-console"
  gem "mina", "0.3.8"
end
