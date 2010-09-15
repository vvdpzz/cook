  Cook::Application.routes.draw do

  # post comment
  post 'comments/create'

  # Questions
  resources :questions do
    resources :answers do
      resources :comments
    end
    resources :comments
    get :autocomplete_tag_name, :on => :collection
  end

  devise_for :users

  root :to => "questions#index"

  end
