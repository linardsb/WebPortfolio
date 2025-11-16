source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 6.0.6'

gem 'pg', '>= 1.0', '< 2.0'

# Pin zeitwerk to 2.6.x for Ruby 3.1.4 compatibility
gem 'zeitwerk', '~> 2.6.0'

gem 'puma', '~> 5.6'

gem 'sass-rails', '~> 5.0'
gem 'sassc-rails', '>= 2.1.0'

gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'
gem 'coffee-rails', '~> 4.2'

gem 'turbolinks', '~> 5'

gem 'jbuilder', '~> 2.5'


group :development, :test do

  gem 'byebug', platforms: [:mri, :windows]
end

group :development do

  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:windows, :jruby]
gem 'friendly_id', '~> 5.1.0'
gem 'devise', '~> 4.9'

gem 'bootstrap', '~> 4.6'

gem 'popper_js'

gem 'petergate', '~> 1.8'

gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.2'

gem 'kaminari', '~> 1.1', '>= 1.1.1'

gem 'cocoon', '~> 1.2', '>= 1.2.11'

gem 'gritter', '~> 1.2'

gem 'jquery-ui-rails', '~> 6.0', '>= 6.0.1'

gem 'carrierwave', '~> 2.2'

gem 'mini_magick', '~> 4.8'

gem 'carrierwave-aws', '~> 1.3'

gem 'cloudinary'

gem 'dotenv-rails', '~> 2.2', '>= 2.2.1'

gem 'pry-rails', group: [:development, :test]

gem 'twitter', '~> 6.2'

gem 'redis', '~> 4.0'

gem 'redcarpet', '~> 3.4'

gem 'coderay', '~> 1.1', '>= 1.1.1'

gem 'mutex_m'

ruby "3.1.4"