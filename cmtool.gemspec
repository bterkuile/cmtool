$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cmtool/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cmtool"
  s.version     = Cmtool::VERSION
  s.authors     = ["Benjamin ter Kuile"]
  s.email       = ["bterkuile@gmail.com"]
  s.homepage    = "www.companytools.nl"
  s.summary     = "The CMS extracted from multiple sites"
  s.description = "The CMS extracted from multiple sites"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.2"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
