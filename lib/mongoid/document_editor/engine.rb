module Mongoid
  module DocumentEditor
    class Engine < ::Rails::Engine
      isolate_namespace Mongoid::DocumentEditor

      initializer :assets, group: :all do |app|
        app.config.assets.precompile += ["base/style.css", "base/doc.css", "base/custom.css", "jquery.js", "jquery_ujs.js"]
      end

      config.after_initialize do |app|
        app.routes.prepend do
          mount Mongoid::DocumentEditor::Engine => Mongoid::DocumentEditor.endpoint
        end
      end

    end
  end
end
