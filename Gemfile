source 'https://rubygems.org'

gem 'rails', '3.2.11'

gem 'mysql2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'compass-rails'
  gem 'compass-blueprint'

  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

# views
gem 'jquery-rails'
gem 'haml-rails'
gem 'kaminari'

# authentication & authorization
gem 'authlogic'
gem 'declarative_authorization'

# attachments
gem 'paperclip'
gem 'delayed_paperclip'
gem 'delayed_job_active_record'
gem 'delayed_job_admin'

# xml parsing
gem 'nokogiri'

#gem 'daemons', '1.0.10' # Need this otherwise delayed job won't start when talking to mysql https://github.com/collectiveidea/delayed_job/issues#issue/81

group :development, :test do
    gem 'rspec-rails'

    gem 'railroady'

    gem 'capistrano'
end

group :test do
    gem 'cucumber-rails'

    gem 'capybara'

    gem 'database_cleaner'

    gem 'rspec-expectations'
    gem 'launchy'

    gem 'factory_girl'
    gem 'pickle'

end