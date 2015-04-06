# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'menu/version'

Gem::Specification.new do |spec|
  spec.name          = "menu-cli"
  spec.version       = Menu::VERSION
  spec.authors       = ["Kurt Nelson"]
  spec.email         = ["kurtisnelson@gmail.com"]
  spec.summary       = %q{Maintains a menu of software versions on S3 for self-updating things}
  spec.description   = %q{Manages a list of releases of software versions stored on S3}
  spec.homepage      = "https://github.com/kurtisnelson/menu-cli"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'aws-sdk'
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rdoc'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
