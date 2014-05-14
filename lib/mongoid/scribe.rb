require "mongoid/scribe/version"
require "mongoid/scribe/engine"
require "mongoid/scribe/configuration"
require "mongoid/scribe/configuration/form_configuration"
require "mongoid/scribe/configuration/index_configuration"
require "mongoid/scribe/builders/field"
require "mongoid/scribe/builders/table"
require "mongoid/scribe/builders/relation"

module Mongoid
  module Scribe
    extend ActiveSupport::Autoload

    mattr_accessor :form_configuration
    @@form_configuration  = {}

    mattr_accessor :index_configuration
    @@index_configuration = {}

    mattr_accessor :authentication_filter
    @@authentication_filter = ->() { return true }

    mattr_accessor :endpoint
    @@endpoint = "/documents"

    mattr_accessor :models
    @@models = Mongoid.models

    def self.configure(&block)
      instance_eval(&block)
    end

    def self.fields_for(klass)
      default_fields = {}
      klass.fields.each_pair do |name, options|
        default_fields[name.to_s] = {}
      end
      @@form_configuration.fetch(klass, default_fields)
    end

    def self.index_for(klass)
      default_fields = {}
      klass.fields.each_pair do |name, options|
        next if name.start_with?("_")
        default_fields[name.to_s] = {}
      end
      @@index_configuration.fetch(klass, default_fields)
    end

    def self.form_configuration_for(document_class, &block)
      @@form_configuration[document_class] = {}
      config = FormConfiguration.new(document_class, @@form_configuration[document_class])
      config.evaluate(&block)
    end

    def self.index_configuration_for(document_class, &block)
      @@index_configuration[document_class] = {}
      config = IndexConfiguration.new(document_class, @@index_configuration[document_class])
      config.evaluate(&block)
    end

    def self.authenticate_with(filter)
      @@authentication_filter = filter
    end

    def self.mount_at(endpoint)
      @@endpoint = endpoint
    end

    def self.resources(options={})
      ::Rails::Mongoid.load_models(Rails.application)
      if options[:include]
        @@models = Mongoid.models.select{ |model| Array(options[:include]).include?(model.to_s.underscore.downcase.to_sym) }
      elsif options[:exclude]
        @@models = Mongoid.models.reject{ |model| Array(options[:exclude]).include?(model.to_s.underscore.downcase.to_sym) }
      else
        @@models = Mongoid.models
      end
    end

  end
end
