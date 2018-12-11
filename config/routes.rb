Rails.application.routes.draw do
  
  resources :beers, only: [:create, :new]

  resources :beer_lists, only: [:update]

  patch '/managers/beer_lists/:id/archive', to: "beer_lists#archive", as: 'archive_managers_beer_list'
  post '/managers/beer_lists/:id/archive', to: "beer_lists#archive"

  resources :bars, only: [:show]

  devise_for :managers, path: 'managers', controllers: {
    sessions: 'managers/sessions', registrations: 'managers/registrations'
  }

  resource :managers do 
    resources :bars, only: [:edit, :new] 
    resources :beer_lists, only: [:index, :destroy, :create, :edit]
    resources :beers, only: [:index]
  end 

  resources :bars, only: [:destroy, :create, :update]


  devise_for :users, path:  'users', controllers: {
    sessions: 'users/sessions'
  }

  resources :autocomplete, only: [:index], format: "json"
  get 'resultpage/index' , to: "resultpage#index"
  get 'contact', to: "contact#index"
  get 'apropos', to: "apropos#index"
  get 'mentions-legales', to: "mentionlegale#index"
  root 'home#index'

  resources :map, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


