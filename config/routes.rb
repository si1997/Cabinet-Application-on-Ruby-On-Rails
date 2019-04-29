Rails.application.routes.draw do

  devise_for :users
  get 'welcome/index'


  resources :docs
  authenticated :user do
    root "docs#index", as: "authenticated_root"
  end

  root 'welcome#index' #now this will be the root of our application


end
