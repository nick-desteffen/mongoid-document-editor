module Mongoid
  module Scribe
    class DocumentsController < ApplicationController

      layout "mongoid/scribe/layouts/application"

      before_filter :setup_klass, except: [:all]

      def all
      end

      def index
        @documents = @klass.all.asc(:created_at)
      end

      def edit
        @document = @klass.find(params[:id])
      end

      def update
        @document = @klass.find(params[:id])
        if @document.update_attributes(cast_bson_attributes(document_params))
          redirect_to document_path(params[:type], @document.id)
        else
          render :edit
        end
      end

      def show
        @document = @klass.find(params[:id])
      end

      def destroy
        @document = @klass.find(params[:id])
        @document.destroy

        redirect_to documents_path(params[:type])
      end

      def new
        @document = @klass.new
      end

      def create
        @document = @klass.new(cast_bson_attributes(document_params))
        if @document.save
          redirect_to documents_path(params[:type])
        else
          render :new
        end
      end

    private

      def document_params
        params.require(params[:type].to_sym).permit!
      end

      def setup_klass
        @klass = params[:type].classify.constantize
      end

      def cast_bson_attributes(parameters)
        bson_attributes = @klass.fields.select do |key, field|
          [Object, BSON::ObjectId].include?(@klass.fields[key].type)
        end

        parameters.each do |key, value|
          if bson_attributes.include?(key)
            parameters[key] = BSON::ObjectId.from_string(value)
          end
        end
        return parameters
      end

    end
  end
end
