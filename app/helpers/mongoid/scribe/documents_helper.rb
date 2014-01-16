module Mongoid
  module Scribe
    module DocumentsHelper

      def model_param(model)
        model.to_s.underscore.downcase
      end

      def relation_label(relation)
        if relation.respond_to?(:slug)
          return relation.slug
        else
          return relation.id
        end
      end

    end
  end
end
