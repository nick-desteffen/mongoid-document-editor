module Mongoid
  module DocumentEditor
    class ApplicationController < ::ApplicationController
      include DocumentsHelper

      before_filter Mongoid::DocumentEditor.authentication_filter

    end
  end
end
