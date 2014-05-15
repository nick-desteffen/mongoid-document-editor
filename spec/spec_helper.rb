require 'rubygems'
require 'bundler/setup'
require 'combustion'
require 'factory_girl_rails'
require 'database_cleaner'
require 'pry'

Combustion.initialize! :action_controller, :action_view, :sprockets

require 'rspec/rails'

RSpec.configure do |config|
  config.render_views
  config.order = :random

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"
  end

  config.before(:each) do
    DatabaseCleaner.clean
    Mongoid::IdentityMap.clear
  end

end

I18n.enforce_available_locales = false

FactoryGirl.define do
  factory :user do
    first_name "Jon"
    last_name "Doe"
    sequence(:email) { |n| "user#{n}@example.com" }
  end
end
