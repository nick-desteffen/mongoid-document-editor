module Mongoid
  module DocumentEditor
    class DocumentsController < ApplicationController
      include DocumentsHelper

      layout "mongoid/document_editor/layouts/application"

      before_filter Mongoid::DocumentEditor.authentication_filter

      def index
      end

      def edit
        @klass    = params[:type].classify.constantize
        @document = @klass.find(params[:id])
      end

      def update
        @klass    = params[:type].classify.constantize
        @document = @klass.find(params[:id])
        @document.update_attributes(document_params)

        redirect_to edit_document_path(params[:type], @document.id)
      end

private

      def document_params
        params.require(params[:type].to_sym).permit!
      end

    end
  end
end
