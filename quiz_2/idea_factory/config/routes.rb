Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 resources :ideas  do
  resources :reviews, only: [:create, :destroy]
  resources :likes, shallow: true, only: [:create, :destroy]
  get :liked, on: :collection
 end


#  only:[:new, :create, :show, :index,:edit,:destroy, :update]
 resources :users, only: [:new, :create]
 get('/', {to: 'welcome#index', as: 'root'})

 resource :session, only: [:new, :create, :destroy]
  get '/users/:id/password', { to: "users#password", as: 'password' }

end
