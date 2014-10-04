module Mongoid
  module Scribe
    module Builders
      class Field
        include ActionView::Helpers::FormHelper
        include ActionView::Context

        def initialize(form, klass, document, name, config)
          @form         = form
          @klass        = klass
          @document     = document
          @name         = name.to_s
          @config       = config
          @label_method = @config.fetch(:label, :id)
          @value_method = @config.fetch(:value, :id)
          @type         = @config.fetch(:type, nil)
          @polymorphic  = false
        end

        def field
          return nil if private_field?

          if @klass.fields[@name].type == Boolean
            form_field = @form.check_box(@name)
          elsif @klass.fields[@name].type == Integer
            form_field = @form.number_field(@name)
          elsif @type == :textarea
            form_field = @form.text_area(@name)
          elsif (@name =~ /email/) || (@type == :email)
            form_field = @form.email_field(@name)
          elsif @klass.fields[@name].type == Array && values
            form_field = checkbox_array
          elsif values && values.all?{ |value| value.is_a?(Mongoid::Document) || value.is_a?(Mongoid::Criteria) }
            if @polymorphic
              options = values.map do |value|
                [
                  value.send(@label_method),
                  value.send(@value_method),
                  {data: {type: value.class.name}}
                ]
              end
              form_field = @form.select(@name, options, {}, {class: "polymorphic"})
              form_field += @form.hidden_field(@name.gsub("_id", "_type"))
            else
              form_field = @form.collection_select(@name, values, @value_method, @label_method)
            end
          elsif values
            form_field = @form.select(@name, values)
          else
            form_field = @form.text_field(@name)
          end

          return content_tag(:div, (label + form_field).html_safe, class: 'control-group')
        end

      private

        def values
          return @values if @values
          @polymorphic = false
          @values = @config.fetch(:values, nil)
          if @values.respond_to?(:call) && @values.arity == 1
            @values = @values.call(@document)
          elsif @values.respond_to?(:call)
            @values = @values.call
          elsif relation = @document.relations.values.detect{ |data| data.key == @name }
            if relation.polymorphic?
              @polymorphic = true
              @values = polymorphic_values(relation.name)
            else
              @values = relation.class_name.constantize.all
            end
          end
        end

        def label
          @form.label(@name, class: "stacked")
        end

        def private_field?
          return true if @name.start_with?("_")
          return true if ["created_at", "updated_at"].include?(@name)
          return false
        end

        def field_name(model)
          model.to_s.underscore.downcase
        end

        def checkbox_array
          values.each_with_index.map do |record, index|
            dom_id  = "#{field_name(record.class.name)}_#{index}"
            checked = @document.send(@name).include?(record.send(@value_method))
            label_tag(record.send(@label_method), nil, for: dom_id, class: "stacked") do
              check_box_tag("#{field_name(@klass)}[#{@name}][]", record.send(@value_method), checked, id: dom_id) +
              content_tag(:span, record.send(@label_method))
            end
          end.join("\n").html_safe
        end

        def polymorphic_values(association_name)
          classes = Mongoid.models.select do |model|
            model.relations.select{|k, v| v[:as] == association_name }.any?
          end

          records = classes.inject([]) do |memo, klass|
            memo += klass.all
            memo
          end

          return records
        end

      end
    end
  end
end
