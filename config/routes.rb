Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :edit, :show, :update]
  resource :session, only: [:create, :new, :destroy]
  resources :subs, except: [:destroy] do
    resources :posts, only: [:new]
  end
  resources :posts, except: [:new, :index]
  root 'users#index'
end
