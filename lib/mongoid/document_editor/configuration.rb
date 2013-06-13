module Mongoid
  module DocumentEditor

    class Configuration

      def initialize(document_class, configuration, &block)
        @document_class = document_class
        @configuration  = configuration
      end

      def evaluate(&block)
        @self_before_instance_eval = eval("self", block.binding)
        instance_eval(&block)
      end

      def method_missing(method, *args, &block)
        @self_before_instance_eval.send(method, *args, &block)
      end
    end

  end
end
