Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  # root 'jobs#index'

  # devise_for :users
  devise_for :users, :controllers => { :registrations => "users/registrations" }

  namespace :admin do
    resources :jobs do
      member do
        post :publish
        post :hide
      end
      resources :resumes
    end
  end

  # resources :jobs
  resources :jobs do
    resources :resumes
  end

end
