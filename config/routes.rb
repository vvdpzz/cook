  Cook::Application.routes.draw do

  # post comment
  post 'comments/create'

  # Votes
  get "votes/vote_up"

  get "votes/vote_down"
  
  # Answers
  match 'questions/:id/latest'  => 'questions#answer_latest',  :via => 'get', :as => :answer_latest
  match 'questions/:id/vote'    => 'questions#answer_vote',    :via => 'get', :as => :answer_vote
  
  # Questions
  match 'questions/latest'  => 'questions#latest',  :via => 'get'
  match 'questions/active'  => 'questions#active',  :via => 'get'
  match 'questions/vote'    => 'questions#vote',    :via => 'get'
  
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
