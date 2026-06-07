require 'momentjs-rails'

require "cmtool/engine"
require 'cmtool/includes/user'
require 'cmtool/includes/page'
require 'cmtool/includes/pages_controller'
require 'cmtool/menu'
require 'email_validator'

# Paperclip replacement — stores file metadata as CouchDB properties,
# handles thumbnail generation via MiniMagick.
# Replace `include Paperclip::Glue` + `has_attached_file` with
# `include SimplyCouch::HasAttachment` + `has_attachment`
# has_attachment now in simply_couch gem

module Cmtool
end
