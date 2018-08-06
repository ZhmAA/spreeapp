Rails.application.routes.draw do
  mount Spree::Core::Engine, at: '/'

  Spree::Core::Engine.add_routes do
    namespace :admin do
      resources :categories
      resources :items
    end
    resources :categories
    resources :items
  end
end
