=begin
require 'couch_potato'
require 'simply_stored'
require 'email_validator'
require 'devise'
require 'devise_simply_stored'
require 'haml-rails'
require 'sass-rails'
require 'tinymce-rails'
require 'paperclip'
require 'jquery-rails'
require 'bourbon'
=end
module Cmtool
  class Engine < ::Rails::Engine
    isolate_namespace Cmtool
    initializer "cmtool" do
    end
    ActiveSupport.on_load(:action_view) do
      require File.expand_path('../../../app/helpers/cmtool/application_helper', __FILE__)
      ::ActionView::Base.send :include, Cmtool::ApplicationHelper
    end
  end
end
