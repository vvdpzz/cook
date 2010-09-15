  Cook::Application.routes.draw do

  # post comment
  post 'comments/create'

  # Votes
  get "votes/vote_up"

  get "votes/vote_down"
  
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
