Rails.application.routes.draw do
  resources :comments
  get '/about', to: 'posts#about'
  get '/contact', to: 'posts#contact'

  root to: "posts#index"

  namespace 'admin' do
    resources :users do
      get :login, on: :collection
      get :logout, on: :collection
      post :do_login, on: :collection
    end
  end
  resources :posts do
    resources :comments
  end
end

# ======= routes ========
# action_namespace_controller_path
# login_admin_users_path
  # get '/teste123' => 'admin/users#index', :as   => :login
# =======================