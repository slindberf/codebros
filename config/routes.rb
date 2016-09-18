Rails.application.routes.draw do
  devise_for :users

  get 'projects/new'

  get 'projects/create'

  get 'projects/show'

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
