# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid/scribe/version'

Gem::Specification.new do |spec|
  spec.name          = "mongoid_scribe"
  spec.version       = Mongoid::Scribe::VERSION
  spec.authors       = ["Nick DeSteffen"]
  spec.email         = ["nick.desteffen@gmail.com"]
  spec.description   = %q{Write a gem description}
  spec.summary       = %q{Write a gem summary}
  spec.homepage      = "https://github.com/nick-desteffen/mongoid-scribe"
  spec.license       = "MIT"

  spec.files         =  Dir.glob("lib/**/*")
  spec.files         += Dir.glob("app/**/*")
  spec.files         += Dir.glob("config/**/*")
  spec.files         += Dir.glob("vendor/**/*")
  spec.files         += %w(README.md LICENSE.txt mongoid_scribe.gemspec)

  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 3.2.0"
  spec.add_dependency "mongoid", "~> 3.1.0"
  spec.add_dependency "strong_parameters"
  spec.add_dependency "jquery-rails"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
