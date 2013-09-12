# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid/document_editor/version'

Gem::Specification.new do |spec|
  spec.name          = "mongoid_document_editor"
  spec.version       = Mongoid::DocumentEditor::VERSION
  spec.authors       = ["Nick DeSteffen"]
  spec.email         = ["nick.desteffen@gmail.com"]
  spec.description   = %q{Write a gem description}
  spec.summary       = %q{Write a gem summary}
  spec.homepage      = "https://github.com/nick-desteffen/mongoid-document-editor"
  spec.license       = "MIT"

  spec.files         =  Dir.glob("lib/**/*")
  spec.files         += Dir.glob("app/**/*")
  spec.files         += Dir.glob("config/**/*")
  spec.files         += Dir.glob("vendor/**/*")
  spec.files         += %w(README.md LICENSE.txt mongoid_document_editor.gemspec)

  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 3.2.0"
  spec.add_dependency "simple_form", "~> 2.1.0"
  spec.add_dependency "mongoid", "~> 3.1.0"
  spec.add_dependency "strong_parameters"
  spec.add_dependency "jquery-rails"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
