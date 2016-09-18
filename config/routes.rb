Rails.application.routes.draw do
  get 'projects/new'

  get 'projects/create'

  get 'projects/show'

  get 'projects/destroy'

  get 'projects/index'

  get 'projects/index_all'

  get 'projects/index_participating'

  devise_for :users
  get 'users/new'

  get 'users/create'

  get 'users/show'

  get 'users/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
