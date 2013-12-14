$LOAD_PATH << 'lib'
require 'qiflib_constants'
require 'rake'

Gem::Specification.new do | s |
  s.name        = 'qiflib'
  s.version     = Qiflib::VERSION
  s.date        = Qiflib::DATE
  s.summary     = 'qiflib'
  s.description = 'A ruby library for qif file processing.'
  s.authors     = [ Qiflib::AUTHOR ]
  s.email       = Qiflib::EMAIL
  s.homepage    = 'https://github.com/cjoakim/qiflib'
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.0.0'
  s.has_rdoc    = true
  s.files = FileList[
    'README.rdoc',
    'html/**/*.html',
    'html/**/*.css',
    'lib/**/*.rb'].to_a
  s.add_development_dependency("rspec", ">= 2.14.1")
  s.licenses = ['GPL-3']
end
