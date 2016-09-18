Rails.application.routes.draw do
  devise_for :users

  get 'projects/new', to: 'projects#new'

  post 'projects/create', to: 'projects#create', as: 'create_project'

  get 'projects/:id', to: 'projects#show', as: 'show_project'

  get 'projects/destroy'

  get 'projects/index'

  get 'projects/index_all'

  get 'projects/index_participating'

  get 'users/new'

  get 'users/create'

  get 'users/show'

  get 'users/destroy'

  root 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
