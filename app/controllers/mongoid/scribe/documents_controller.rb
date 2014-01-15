module Mongoid
  module Scribe
    class DocumentsController < ApplicationController

      layout "mongoid/scribe/layouts/application"

      before_filter :setup_klass, except: [:all]

      def all
      end

      def index
        @documents = @klass.all
      end

      def edit
        @document = @klass.find(params[:id])
      end

      def update
        @document = @klass.find(params[:id])
        @document.update_attributes(document_params)

        redirect_to document_path(params[:type], @document.id)
      end

      def show
        @document = @klass.find(params[:id])
      end

      def destroy
        @document = @klass.find(params[:id])
        @document.destroy

        redirect_to documents_path(params[:type])
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
