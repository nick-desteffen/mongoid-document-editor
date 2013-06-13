module Mongoid
  module DocumentEditor
    module DocumentsHelper

      def document_edit_field(form, klass, document, name, config)
        name = name.to_s
        return nil if private_field?(name)

        values = config.fetch(:values, nil)
        if values.respond_to?(:call) && values.arity == 1
          values = values.call(document)
        elsif values.respond_to?(:call)
          values = values.call
        end

        label   = config.fetch(:label, :name)
        value   = config.fetch(:value, :id)
        type    = config.fetch(:type, nil)
        options = {}
        options = {as: :boolean} if klass.fields[name].type == Boolean
        options = {as: :numeric} if klass.fields[name].type == Integer
        options = {as: :text}    if type == :text
        options = {collection: values} if values.present?

        options.merge!(label_method: label, value_method: value) if config[:label] && config[:value]

        if klass.fields[name].type == Array && values
          return form.collection_check_boxes(name, values, value, label)
        else
          return form.input(name, options)
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
