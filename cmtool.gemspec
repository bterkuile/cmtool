# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'cmtool/version'

Gem::Specification.new do |s|
  s.name = "cmtool"
  s.version = Cmtool::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Benjamin ter Kuile"]
  s.date = "2014-07-14"
  s.description = "A rails 3.2+ CMS as engine for a CouchDB backend"
  s.email = ["bterkuile@gmail.com"]
  s.files = `git ls-files`.split("\n")
  s.homepage = "https://github.com/bterkuile/cmtool"
  s.rubygems_version = "2.2.2"
  s.summary = "A rails 3.2+ CMS as engine for a CouchDB backend"
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_runtime_dependency "email_validator", ">= 0"
  # s.add_runtime_dependency "bourbon", ">= 0"
  s.add_runtime_dependency "slim-rails", ">= 0"
  # s.add_runtime_dependency "tinymce-rails", ">= 0"
  s.add_runtime_dependency "jquery-rails", ">= 0"
  s.add_runtime_dependency "paperclip", ">= 0"
  s.add_runtime_dependency "foundation-rails", ">= 0"
  s.add_runtime_dependency "ace-rails-ap", ">= 0"
  s.add_runtime_dependency "font-awesome-rails", ">= 0"
  s.add_runtime_dependency "pickadate-rails", ">= 0"
end
