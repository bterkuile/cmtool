Cmtool::Engine.routes.draw do
  #devise_for :users, :controllers => {:sessions => 'cmtool/sessions', :passwords => 'cmtool/passwords'}
  root :to => "pages#index"
  resources :directories
  resources :images
  resources :period_extensions
  resources :pages do
    member do
      get :generate_name
      match :preview, via: [:get, :post]
    end
    collection do
      get :generate_name
      get :sitemap
    end
  end
  resources :news do
    member do
      delete :remove_image
    end
  end
  resources :yml_files
  resources :keywords
  resources :faqs
  resources :quotes do
    member do
      delete :remove_image
    end
  end

  # ADMIN FORMS
  resources :contact_forms do
    collection do
      post :add
    end
  end
  resources :newsletter_subscriptions do
    collection do
      post :add
    end
  end

  # USER MANAGEMENT
  resources :users
end
