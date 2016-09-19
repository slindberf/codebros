Rails.application.routes.draw do
  root 'site#index'

  devise_for :users

  get 'users/show', to: 'users#show', as: 'show_user'

  get 'projects/new', to: 'projects#new'

  post 'projects/create', to: 'projects#create', as: 'create_project'

  

  get 'projects/destroy'

  get 'projects/index'

  get 'projects/index_all'

  get 'projects/index_participating'

  get 'projects/:id', to: 'projects#show', as: 'show_project'

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
