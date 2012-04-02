Rails.application.routes.draw do

  devise_for :users, :controllers => {:sessions => 'cmtool/sessions', :passwords => 'cmtool/passwords'}
  mount Cmtool::Engine => "/cmtool"
  match "/:name" => "pages#show"
  match "/*url" => "pages#not_found"
  root :to => 'pages#home'
end
