  Cook::Application.routes.draw do

  get "tagged/index"

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
  
  # tagged
  match 'tagged/:tag'       => 'tagged#index',      :via => 'get',  :as => :tagged
  match 'tagged/:tag/latest'=> 'tagged#latest',     :via => 'get',  :as => :tagged_latest
  match 'tagged/:tag/active'=> 'tagged#active',     :via => 'get',  :as => :tagged_active 
  match 'tagged/:tag/vote'  => 'tagged#vote',       :via => 'get',  :as => :tagged_vote

  devise_for :users

  root :to => "questions#index"

  end
