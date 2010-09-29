  Cook::Application.routes.draw do
  # Tags
  match 'tags/nameabc'      => 'tags#nameabc',      :via => 'get'
  match 'tags/popular'      => 'tags#popular',      :via => 'get'
  resources :tags
  
  #favorites
  match 'questions/:id/favorites' => 'favorites#create', :as => :favorites, :via => 'get'

  # post comment
  post 'comments/create'

  # Votes
  get "votes/vote_up"

  get "votes/vote_down"
  
  # Answers
  match 'questions/:id/latest'  => 'questions#answer_latest',  :via => 'get', :as => :answer_latest
  match 'questions/:id/vote'    => 'questions#answer_vote',    :via => 'get', :as => :answer_vote
  
  # Accepte answer
  match 'questions/:id/accept/:accept' => 'questions#accept', :as => :accept
  
  # Questions
  match 'questions/latest'  => 'questions#latest',  :via => 'get'
  match 'questions/active'  => 'questions#active',  :via => 'get'
  match 'questions/vote'    => 'questions#vote',    :via => 'get'
  match 'search' => 'questions#search', :via => 'get'
  
  # Unanswered
  match 'unanswered'        => 'unanswered#index',  :via => 'get'
  match 'unanswered/latest' => 'unanswered#latest', :via => 'get'
  match 'unanswered/active' => 'unanswered#active', :via => 'get'
  match 'unanswered/vote'   => 'unanswered#vote',   :via => 'get'
  
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
  
  # tagged
  match 'tagged/:tag'       => 'tagged#index',      :via => 'get',  :as => :tagged
  match 'tagged/:tag/latest'=> 'tagged#latest',     :via => 'get',  :as => :tagged_latest
  match 'tagged/:tag/active'=> 'tagged#active',     :via => 'get',  :as => :tagged_active 
  match 'tagged/:tag/vote'  => 'tagged#vote',       :via => 'get',  :as => :tagged_vote

  # Users
  match 'users/rp'          => 'users#rp',          :via => 'get'
  match 'users/oldest'      => 'users#oldest',      :via => 'get'

  # Devise
  devise_for :users
  
  resources :users

  root :to => "questions#index"

  end
