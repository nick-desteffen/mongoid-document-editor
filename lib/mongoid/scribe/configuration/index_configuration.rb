module Mongoid
  module Scribe

    class IndexConfiguration < Configuration
      def column(name, options={})
        @configuration[name] = options
      end
    end

  end
end
