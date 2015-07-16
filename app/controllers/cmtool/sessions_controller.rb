module Cmtool
  class SessionsController < ::Devise::SessionsController
    include Cmtool::ControllerGlue
    layout 'cmtool/devise'
  end
end
