module Mongoid
  module Scribe
    module Builders
      class Relation
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::UrlHelper
        include ActionView::Context

        def initialize(document, relation)
          @document = document
          @relation = relation
        end

        def listing
          output = content_tag(:h4, @relation)
          Array(@document.send(@relation)).sort_by(&:created_at).each do |record|
            link = link_to(relation_label(record), Mongoid::Scribe::Engine.routes.url_helpers.document_path(model_param(record.class.name), record.send(:id)))
            output += content_tag(:p, link)
          end
          return output.html_safe
        end

      private

        def relation_label(relation)
          if relation.respond_to?(:slug)
            return relation.slug
          else
            return relation.id
          end
        end

        def model_param(model)
          model.to_s.underscore.downcase
        end

      end
    end
  end
end
