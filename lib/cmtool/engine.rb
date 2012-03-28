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
module Cmtool
  class Engine < ::Rails::Engine
    isolate_namespace Cmtool
  end
end
