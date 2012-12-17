module Cmtool
  class ApplicationController < ::ApplicationController
    before_filter :authenticate_user!, :authorize_user, :check_environment, :set_locale

    private

    def set_locale
      if respond_to? :cmtool_locale
        I18n.locale = cmtool_locale
      else
        I18n.locale = :en
      end
    end

    def authorize_user
      if respond_to? :authorize_cmtool, true
        authorize_cmtool
      else
        render text: 'Please define authorize_cmtool in your application controller. This area needs to be secured!', status: 403
      end
    end

    def check_environment
      @cmtool_warnings ||= []
      @cmtool_warnings << 'no_host_specified' unless ( Rails.application.config.action_mailer.default_url_options[:host] rescue false) ||
        Rails.application.default_url_options[:host].present?
    end
  end
end
