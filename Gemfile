source "http://rubygems.org"

# Declare your gem's dependencies in cmtool.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

group :assets do
  gem 'sass-rails'
  gem 'bourbon'
  gem 'coffee-script'
  #gem 'therubyracer', :platforms => :ruby
  #gem 'less-rails'
  gem 'bootstrap-sass'
end

gem 'couch_potato' , github: 'bterkuile/couch_potato'
gem 'simply_stored' , github: 'bterkuile/simply_stored'
gem 'orm_adapter', github: 'bterkuile/orm_adapter'
gem 'devise'
gem 'devise_simply_stored'
gem 'tinymce-rails'
gem 'haml-rails'
gem 'slim-rails'
gem 'paperclip'
gem 'email_validator'
# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# jquery-rails is used by the dummy application
gem "jquery-rails"
# To use debugger
group :test do
  gem 'steak'
  gem 'factory_girl_rails'
end
group :development do
  gem 'thin'
  #gem 'ruby-debug19', :require => 'ruby-debug'
end
