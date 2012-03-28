module Cmtool
  class ApplicationController < ::ApplicationController
    before_filter :authenticate_user!, :set_locale

    private

    def set_locale
      if respond_to? :cmtool_locale
        I18n.locale = :cmtool_locale
      else
        I18n.locale = :en
      end
    end
  end
end
