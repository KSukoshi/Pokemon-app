Rails.application.routes.draw do
  resources :pokemon_abilities
  get 'pokemon_abilities/new'
  get 'pokemon_abilities/create'
  get 'pokemon_abilities/update'
  get 'pokemon_abilities/edit'
  get 'pokemon_abilities/destroy'
  get 'pokemon_abilities/index'
  get 'pokemon_abilities/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
