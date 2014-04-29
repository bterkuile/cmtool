class User
  include Cmtool::Includes::User
  devise :database_authenticatable, :recoverable, :rememberable, :trackable
end
