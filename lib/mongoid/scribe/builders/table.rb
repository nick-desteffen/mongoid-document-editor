module Mongoid
  module Scribe
    module Builders
      class Table

        def initialize(document, header, config)
          @document = document
          @header   = header
          @config   = config
        end

        def header
        end

        def cell
          if @config[:value] && @config[:value].respond_to?(:call)
            return @config[:value].call(@document)
          else
            return @document.send(@header)
          end
        end

      end
    end
  end
end
