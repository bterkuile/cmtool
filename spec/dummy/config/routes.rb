Rails.application.routes.draw do

  devise_for :users, :controllers => {:sessions => 'cmtool/sessions', :passwords => 'cmtool/passwords'}
  mount Cmtool::Engine => "/cmtool"
  get "/:name" => "pages#show"
  get "/*url" => "pages#not_found"
  root :to => 'pages#home'
end
