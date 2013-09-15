require 'rails/generators'

module MongoidDocumentEditor
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc "Generate Mongoid Document Editor Initializer"

      def generate_initializer
        copy_file "config/initializers/mongoid_document_editor.rb", "config/initializers/mongoid_document_editor.rb"
      end

    end
  end
end
