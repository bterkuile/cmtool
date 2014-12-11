# -*- encoding: utf-8 -*-
# stub: cmtool 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "cmtool"
  s.version = "1.0.0"

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

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<email_validator>, [">= 0"])
      s.add_runtime_dependency(%q<bourbon>, [">= 0"])
      s.add_runtime_dependency(%q<slim-rails>, [">= 0"])
      s.add_runtime_dependency(%q<tinymce-rails>, [">= 0"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 0"])
      s.add_runtime_dependency(%q<paperclip>, [">= 0"])
    else
      s.add_dependency(%q<email_validator>, [">= 0"])
      s.add_dependency(%q<bourbon>, [">= 0"])
      s.add_dependency(%q<slim-rails>, [">= 0"])
      s.add_dependency(%q<tinymce-rails>, [">= 0"])
      s.add_dependency(%q<jquery-rails>, [">= 0"])
      s.add_dependency(%q<paperclip>, [">= 0"])
    end
  else
    s.add_dependency(%q<email_validator>, [">= 0"])
    s.add_dependency(%q<bourbon>, [">= 0"])
    s.add_dependency(%q<slim-rails>, [">= 0"])
    s.add_dependency(%q<tinymce-rails>, [">= 0"])
    s.add_dependency(%q<jquery-rails>, [">= 0"])
    s.add_dependency(%q<paperclip>, [">= 0"])
  end
end
