require 'sidekiq/web'

Dysnomia::Application.routes.draw do
  resources :pads

  devise_for :users, :controllers => { :invitations => 'users/invitations', :sessions => 'users/sessions' }
  resources :uploads

  resources :tasks do
    collection do
      put :complete
      delete :destroy_multiple
    end
  end
  
  resources :events do
    member do
      put :add_exception
    end
  end

  resources :tenants
  resources :categories
  
  resources :pages do
    collection do
      get :start 
    end
  end

  resources :users do
    collection do
      put :approve
      delete :destroy_multiple
    end
  end

  resources :activities
  resources :channels do
    member do
      put :unsubscribe
      put :toggle_muted
      post :subscribe_users
    end

    resources :messages, shallow: true do
      delete :index, on: :collection, action: :destroy_all
      put :index, on: :collection, action: :mark_all_read
    end
  end

  root 'activities#index'
  
  get 'calendar' => 'calendar#index'
  get 'forum' => 'forum#index'
  get 'discourse_sso' => 'discourse_sso#index'

  # Error handling
  %w( 404 422 500 ).each do |code|
    get code, :to => "errors#show", :code => code
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
