Rails.application.routes.draw do
  devise_for :users
  get 'users/new'

  get 'users/create'

  get 'users/show'

  get 'users/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
