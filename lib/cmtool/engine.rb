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
    initializer "cmtool.build_menu" do
      require 'email_validator'
      require 'bourbon'
      require 'slim-rails'
      require 'haml-rails'
      Cmtool::Menu.register do
        group label: :site do
          title t('cmtool.menu.site.title')
          resource_link Page, scope: Cmtool
          resource_link Cmtool::Keyword
        end
        group label: :publications do
          title t('cmtool.menu.publications.title')
          resource_link Cmtool::News
          resource_link Cmtool::Faq
          resource_link Cmtool::Quote
        end
        group label: :forms do
          title t('cmtool.menu.forms.title')
          resource_link Cmtool::ContactForm
          resource_link Cmtool::NewsletterSubscription
        end
        group label: :files do
          title t('cmtool.menu.files.title')
          resource_link Cmtool::Image
          resource_link Cmtool::Directory
        end

        resource_link User, label: :users, scope: Cmtool
      end
    end
    ActiveSupport.on_load(:action_view) do
      require File.expand_path('../../../app/helpers/cmtool/application_helper', __FILE__)
      ::ActionView::Base.send :include, Cmtool::ApplicationHelper
    end
  end
end
