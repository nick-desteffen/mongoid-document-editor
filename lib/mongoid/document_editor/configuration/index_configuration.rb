module Mongoid
  module DocumentEditor

    class IndexConfiguration < Configuration
      def column(name, options={})
        @configuration[name] = options
      end
    end

  end
end
