module Mongoid
  module DocumentEditor
    class DocumentsController < ApplicationController
      include DocumentsHelper

      layout "mongoid/document_editor/layouts/application"

      before_filter Mongoid::DocumentEditor.authentication_filter
      before_filter :setup_klass

      def index
        @documents = @klass.all
      end

      def edit
        @document = @klass.find(params[:id])
      end

      def update
        @document = @klass.find(params[:id])
        @document.update_attributes(document_params)

        redirect_to edit_document_path(params[:type], @document.id)
      end

private

      def document_params
        params.require(params[:type].to_sym).permit!
      end

      def setup_klass
        @klass = params[:type].classify.constantize
      end

    end
  end
end
