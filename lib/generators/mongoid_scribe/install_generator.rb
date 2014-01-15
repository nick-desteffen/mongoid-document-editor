require 'rails/generators'

module MongoidScribe
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc "Generate Mongoid Scribe Initializer"

      def generate_initializer
        copy_file "config/initializers/mongoid_scribe.rb", "config/initializers/mongoid_scribe.rb"
      end

    end
  end
end
