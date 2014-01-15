module Mongoid
  module Scribe

    class FormConfiguration < Configuration
      def field(name, options={})
        @configuration[name] = options
      end
    end

  end
end
