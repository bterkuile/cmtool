$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cmtool/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cmtool"
  s.version     = Cmtool::VERSION
  s.authors     = ["Benjamin ter Kuile"]
  s.email       = ["bterkuile@gmail.com"]
  s.homepage    = "https://github.com/bterkuile/cmtool"
  s.summary     = "A rails 3.2+ CMS as engine for a CouchDB backend"
  s.description = "A rails 3.2+ CMS as engine for a CouchDB backend"

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 4.1.0"
  s.add_dependency 'email_validator'
  s.add_dependency 'bourbon'
  s.add_dependency 'haml-rails'
  s.add_dependency 'slim-rails'
  #s.add_dependency 'sass-rails'
  s.add_dependency 'tinymce-rails'
  #s.add_dependency 'paperclip'
  #s.add_dependency 'coffee-script'
  s.add_dependency "jquery-rails"
  #s.add_dependency 'devise'
  #s.add_dependency 'devise_simply_stored'

  #s.add_development_dependency "sqlite3"
end
