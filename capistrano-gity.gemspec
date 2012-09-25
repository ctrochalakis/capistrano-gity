# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "capistrano-gity"
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Skroutz.gr Team"]
  s.date = "2012-05-21"
  s.email = "yatiohi@ideopolis.gr"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "capistrano-gity.gemspec",
    "lib/capistrano-gity.rb"
  ]
  s.homepage = "http://github.com/ctrochalakis/capistrano-gity"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "Git helpers for capistrano deployments"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

