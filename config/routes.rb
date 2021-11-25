Rails.application.routes.draw do

  namespace :admin do

    root :to => "main#index"

    resources :main
    resources :posts

    #resources libera as rotas padrões do rails
    # index
    # edit
    # new
    # show
    # destroy
    # crete
    # update
    # action_nmespace_controller

    resources :users do
      get :login, on: :collection
      get :logout, on: :collection
      post :do_login, on: :collection
    end

  end

  # action_controller
  resources :posts
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
