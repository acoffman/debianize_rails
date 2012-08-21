lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'debianize_rails/version'

Gem::Specification.new do |s|
  s.name                      = "debianize_rails"
  s.version                   = DebianizeRails::VERSION
  s.platform                  = Gem::Platform::RUBY
  s.required_ruby_version     = '>= 1.9'
  s.required_rubygems_version = ">= 1.3"
  s.authors                   = ["Adam Coffman"]
  s.email                     = ["acoffman@genome.wustl.edu"]
  s.executables               = ["debianize_rails"]
  s.homepage                  = "http://github.com/crohr/pkgr"
  s.summary                   = "Package your Rails app as a debian package"
  s.description               = "Simple autogeneration of debian/ directory files and package building"

  s.files = Dir.glob("{lib}/**/*") + %w(LICENSE README.md)

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.require_path = 'lib'
end
