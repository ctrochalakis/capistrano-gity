# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name             = 'capistrano-gity'
  s.version          = '1.0.2'
  s.authors          = ['Skroutz.gr Team']
  s.date             = '2012-05-21'
  s.email            = 'yatiohi@ideopolis.gr'
  s.extra_rdoc_files = ['LICENSE', 'README.md']
  s.files            = `git ls-files`.split($/)
  s.homepage         = 'http://github.com/ctrochalakis/capistrano-gity'
  s.require_paths    = ['lib']
  s.rubygems_version = '1.8.11'
  s.summary          = 'Git helpers for Capistrano v3 deployments'

  s.add_dependency 'capistrano', '~> 3.1'
  s.add_dependency 'sshkit', '~> 1.2'
end
