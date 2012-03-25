Rails.application.routes.draw do

  devise_for :users, :controllers => {:sessions => 'cmtool/sessions', :passwords => 'cmtool/passwords'}
  mount Cmtool::Engine => "/cmtool"
end
