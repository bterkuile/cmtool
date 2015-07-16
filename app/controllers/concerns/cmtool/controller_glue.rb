module Cmtool::ControllerGlue
  extend ActiveSupport::Concern
  included do
    helper_method :cmtool_user
  end

  def cmtool_user
    defined?(super) ? super : current_user
  end

end
