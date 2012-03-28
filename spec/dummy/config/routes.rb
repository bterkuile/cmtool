Rails.application.routes.draw do

  devise_for :users, :controllers => {:sessions => 'cmtool/sessions', :passwords => 'cmtool/passwords'}
  match "/:name" => "pages#show"
  match "/*url" => "pages#not_found"
  root :to => 'pages#home'
  mount Cmtool::Engine => "/cmtool"
end
