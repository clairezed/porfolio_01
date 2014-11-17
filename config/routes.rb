Rails.application.routes.draw do

  # Concerns =======================================

  concern :positionable do
    patch :position, on: :member
  end

  # Admin ==========================================

  devise_for :admin

  namespace :admin do
    resources :projects, except: [:show], concerns: :positionable do
      get :get_picture_form, on: :collection
      patch :sort_picture, on: :member
      put :toggle_visible, on: :member
      put :toggle_highlighted, on: :member
    end
    resources :tags, only: [:index, :destroy] do
      put :check, on: :member
      get :autocomplete, on: :collection
      # put :destroy_project_tag, on: :member
    end
    resources :tasks, only: [:index, :destroy] do
      put :check, on: :member
      get :autocomplete, on: :collection
      # put :destroy_project_tag, on: :member
    end
    resources :project_tags, only: [:destroy]
    resources :project_tasks, only: [:destroy]


    root to: "dashboard#index"
  end

   # Front ==========================================
  resources :projects, only: [:index,:show], path: "projects"

  # resources :contacts, only: [:new, :create, :index], path_names: {new: 'formulaire'}



  get "/:filename", to: "statics#show"

  root to: "home#index"

end
