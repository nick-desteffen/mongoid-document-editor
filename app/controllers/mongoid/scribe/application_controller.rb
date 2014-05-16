module Mongoid
  module Scribe
    class ApplicationController < ::ApplicationController
      include DocumentsHelper

      if Mongoid::Scribe.authentication_filter
        before_filter Mongoid::Scribe.authentication_filter
      end

    end
  end
end
