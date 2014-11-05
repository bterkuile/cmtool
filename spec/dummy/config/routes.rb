Rails.application.routes.draw do

  devise_for :users, :controllers => {:sessions => 'cmtool/sessions', :passwords => 'cmtool/passwords'}
  mount Cmtool::Engine => "/cmtool"
  get '/sitemap(.:format)' => 'test_pages#sitemap'
  get "/:name" => "pages#show"
  scope '(/:locale)', constraints: {locale: /nl|be|de|fr|en/}, defaults: { locale: :nl } do
    get "/:name" => "pages#show", constraints: {name: /.*/},  as: :page
  end
  get "/*url" => "pages#not_found"
  root :to => 'pages#home'
end
