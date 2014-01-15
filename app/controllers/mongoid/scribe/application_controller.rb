module Mongoid
  module Scribe
    class ApplicationController < ::ApplicationController
      include DocumentsHelper

      before_filter Mongoid::Scribe.authentication_filter

    end
  end
end
