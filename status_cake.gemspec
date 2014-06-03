# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: status_cake 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "status_cake"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Charles Cooke"]
  s.date = "2014-06-04"
  s.description = "Ruby gem for StatusCake API - supports basic functions on tests"
  s.email = "charles@coupa.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".env",
    "Gemfile",
    "Gemfile.lock",
    "Guardfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/status_cake.rb",
    "lib/status_cake/status_cake.rb",
    "lib/status_cake/version.rb",
    "spec/fixtures/vcr/create_test.yml",
    "spec/fixtures/vcr/delete_test.yml",
    "spec/fixtures/vcr/pause_test.yml",
    "spec/fixtures/vcr/retrieve_all.yml",
    "spec/fixtures/vcr/retrieve_by_name.yml",
    "spec/fixtures/vcr/unpause_test.yml",
    "spec/spec_helper.rb",
    "spec/status_cake/status_cake_spec.rb"
  ]
  s.homepage = "http://github.com/coupacooke/status_cake"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Ruby gem for StatusCake API"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, ["~> 0.13"])
      s.add_development_dependency(%q<shoulda>, ["~> 3.5"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.8"])
      s.add_development_dependency(%q<dotenv>, ["~> 0.10"])
      s.add_development_dependency(%q<webmock>, ["~> 1.18"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<guard>, ["~> 2.6"])
      s.add_development_dependency(%q<guard-rspec>, ["~> 4.2"])
      s.add_development_dependency(%q<vcr>, ["~> 2.9"])
    else
      s.add_dependency(%q<httparty>, ["~> 0.13"])
      s.add_dependency(%q<shoulda>, ["~> 3.5"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_dependency(%q<simplecov>, ["~> 0.8"])
      s.add_dependency(%q<dotenv>, ["~> 0.10"])
      s.add_dependency(%q<webmock>, ["~> 1.18"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<guard>, ["~> 2.6"])
      s.add_dependency(%q<guard-rspec>, ["~> 4.2"])
      s.add_dependency(%q<vcr>, ["~> 2.9"])
    end
  else
    s.add_dependency(%q<httparty>, ["~> 0.13"])
    s.add_dependency(%q<shoulda>, ["~> 3.5"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0"])
    s.add_dependency(%q<simplecov>, ["~> 0.8"])
    s.add_dependency(%q<dotenv>, ["~> 0.10"])
    s.add_dependency(%q<webmock>, ["~> 1.18"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<guard>, ["~> 2.6"])
    s.add_dependency(%q<guard-rspec>, ["~> 4.2"])
    s.add_dependency(%q<vcr>, ["~> 2.9"])
  end
end

