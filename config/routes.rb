Cmtool::Engine.routes.draw do
  devise_for :users, :controllers => {:sessions => 'cmtool/sessions', :passwords => 'cmtool/passwords'}
  root :to => "pages#index"
  resources :directories
  resources :images
  resources :period_extensions
  resources :pages do
    member do
      get :generate_name
    end
    collection do
      get :generate_name
    end
  end
  resources :news do
    member do
      delete :remove_image
    end
  end
  resources :keywords
  resources :faqs
  resources :quotes do
    member do
      delete :remove_image
    end
  end

  # ADMIN FORMS
  resources :contact_forms
  resources :newsletter_subscriptions

  # USER MANAGEMENT
  resources :users
end
