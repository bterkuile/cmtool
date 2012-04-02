module Cmtool
  class PasswordsController < Devise::PasswordsController
    layout 'cmtool/sessions'
  end
end
