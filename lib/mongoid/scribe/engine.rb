module Mongoid
  module Scribe
    class Engine < ::Rails::Engine
      isolate_namespace Mongoid::Scribe

      initializer :assets, group: :all do |app|
        app.config.assets.precompile += ["base/style.css", "base/doc.css", "base/custom.css", "jquery.js", "jquery_ujs.js"]
      end

      config.after_initialize do |app|
        app.routes.prepend do
          mount Mongoid::Scribe::Engine => Mongoid::Scribe.endpoint
        end
      end

    end
  end
end
