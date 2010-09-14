Cook::Application.routes.draw do


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
