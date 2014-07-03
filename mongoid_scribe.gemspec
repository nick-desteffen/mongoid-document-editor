# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid/scribe/version'

Gem::Specification.new do |spec|
  spec.name          = "mongoid_scribe"
  spec.version       = Mongoid::Scribe::VERSION
  spec.authors       = ["Nick DeSteffen"]
  spec.email         = ["nick.desteffen@gmail.com"]
  spec.description   = %q{Mongoid Scribe}
  spec.summary       = %q{Mongoid Scribe is a Rails Engine that provides a DSL for setting up simple admin interfaces to edit MongoDB documents. No configuration is required in order to get a basic form, however you can override any form you want to provide a more custom and usable interface.}
  spec.homepage      = "https://github.com/nick-desteffen/mongoid-scribe"
  spec.license       = "MIT"

  spec.files         =  Dir.glob("lib/**/*")
  spec.files         += Dir.glob("app/**/*")
  spec.files         += Dir.glob("config/**/*")
  spec.files         += Dir.glob("vendor/**/*")
  spec.files         += %w(README.md LICENSE.txt mongoid_scribe.gemspec)

  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 4.0.0"
  spec.add_dependency "mongoid", ">= 4.0.0"
  spec.add_dependency "jquery-rails"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails", "~> 3.0.0"
  spec.add_development_dependency "combustion", "~> 0.5.1"
  spec.add_development_dependency "pry", "~> 0.9.12.6"
  spec.add_development_dependency "factory_girl_rails", "~> 4.4.0"
  spec.add_development_dependency "database_cleaner", "~> 1.2.0"
end
