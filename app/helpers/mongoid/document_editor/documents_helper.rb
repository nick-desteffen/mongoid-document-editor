module Mongoid
  module DocumentEditor
    module DocumentsHelper

      def document_edit_field(form, klass, document, name, config)
        name = name.to_s
        return nil if private_field?(name)

        ## Fetch collection values
        values = config.fetch(:values, nil)
        if values.respond_to?(:call) && values.arity == 1
          values = values.call(document)
        elsif values.respond_to?(:call)
          values = values.call
        end

        ## Setup label and value
        label_method = config.fetch(:label, :name)
        value_method = config.fetch(:value, :id)
        type         = config.fetch(:type, nil)

        label = form.label(name, class: "stacked")

        if klass.fields[name].type == Boolean
          form_field = form.check_box(name)
        elsif klass.fields[name].type == Integer
          form_field = form.number_field(name)
        elsif type == :textarea
          form_field = form.text_area(name)
        elsif (name =~ /email/) || (type == :email)
          form_field = form.email_field(name)
        elsif klass.fields[name].type == Array && values && values.is_a?(Mongoid::Criteria)
          form_field = values.each_with_index.map do |record, index|
            class_name = model_param(record.name)
            id_value = "#{class_name}_#{index}"
            label_tag(record.send(label_method), nil, for: id_value, class: "stacked") do
              check_box_tag("#{model_param(klass)}[#{name}][]", record.send(value_method), document.send(name).include?(record.send(value_method)), id: id_value) +
              content_tag(:span, record.send(label_method))
            end
          end.join("").html_safe
        elsif values && values.is_a?(Mongoid::Criteria)
          form_field = form.collection_select(name, values, value_method, label_method)
        elsif values
          form_field = form.select(name, values)
        else
          form_field = form.text_field(name)
        end

        return (label + form_field).html_safe
      end

      def cell_value(document, header, config)
        if config[:value] && config[:value].respond_to?(:call)
          config[:value].call(document)
        else
          document.send(header)
        end
      end

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

    private

      def private_field?(name)
        return true if name.start_with?("_")
        return true if ["created_at", "updated_at"].include?(name)
        return false
      end

    end
  end
end
