=begin
require 'couch_potato'
require 'simply_stored'
require 'email_validator'
require 'devise'
require 'devise_simply_stored'
require 'sass-rails'
require 'paperclip'
require 'jquery-rails'
require 'bourbon'
=end
require 'tinymce-rails'
module Cmtool
  class Engine < ::Rails::Engine
    isolate_namespace Cmtool
    initializer 'cmtool.build_menu', after: 'load_config_initializers' do |app|
      require 'email_validator'
      #require 'bourbon'
      require 'slim-rails'
      require 'paperclip'
      require 'devise'
      require 'devise_simply_stored'
      require 'jquery-rails'
      require 'tinymce-rails'

      require 'page' # app/models/page.rb
      require 'user' # app/models/user.rb
      require 'cmtool/yml_file'
      require 'cmtool/keyword'
      require 'cmtool/news'
      require 'cmtool/faq'
      require 'cmtool/quote'
      require 'cmtool/contact_form'
      require 'cmtool/newsletter_subscription'
      require 'cmtool/image'
      require 'cmtool/directory'
    end

    config.after_initialize do
      Cmtool::Menu.register do
        group label: :site do
          title t('cmtool.menu.site.title')
          resource_link Page, scope: Cmtool
          resource_link Cmtool::YmlFile
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
