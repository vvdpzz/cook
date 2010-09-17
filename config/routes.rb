  Cook::Application.routes.draw do

  # Tags
  match 'tags/nameabc'      => 'tags#nameabc',      :via => 'get'
  match 'tags/popular'      => 'tags#popular',      :via => 'get'
  resources :tags

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
  
  # tagged
  match 'tagged/:tag'       => 'tagged#index',      :via => 'get',  :as => :tagged
  match 'tagged/:tag/latest'=> 'tagged#latest',     :via => 'get',  :as => :tagged_latest
  match 'tagged/:tag/active'=> 'tagged#active',     :via => 'get',  :as => :tagged_active 
  match 'tagged/:tag/vote'  => 'tagged#vote',       :via => 'get',  :as => :tagged_vote
  
  resources :questions do
    resources :answers do
      resources :comments
    end
    resources :comments
    get :autocomplete_tag_name, :on => :collection
  end

  # Users
  match 'users/rp'          => 'users#rp',          :via => 'get'
  match 'users/oldest'      => 'users#oldest',      :via => 'get'

  # Devise
  devise_for :users
  
  resources :users

  root :to => "questions#index"

  end
