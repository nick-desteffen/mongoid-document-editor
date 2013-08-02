module Mongoid
  module DocumentEditor
    class Engine < ::Rails::Engine
      isolate_namespace Mongoid::DocumentEditor

      config.after_initialize do |app|
        app.routes.prepend do
          mount Mongoid::DocumentEditor::Engine => Mongoid::DocumentEditor.endpoint
        end
      end

    end
  end
end
