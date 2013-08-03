module Mongoid
  module DocumentEditor
    class Engine < ::Rails::Engine
      isolate_namespace Mongoid::DocumentEditor

      initializer :assets, group: :all do |app|
        app.config.assets.paths += ["vendor/assets/stylesheets/base"]
        app.config.assets.precompile += ["base/style.css", "base/doc.css", "jquery.js", "jquery_ujs.js"]
      end

      config.after_initialize do |app|
        app.routes.prepend do
          mount Mongoid::DocumentEditor::Engine => Mongoid::DocumentEditor.endpoint
        end
      end

    end
  end
end
