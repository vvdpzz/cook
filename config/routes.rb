Cook::Application.routes.draw do

  resources :questions do
    get :autocomplete_tag_name, :on => :collection
  end

  devise_for :users

  root :to => "questions#index"

end
