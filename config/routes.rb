Rails.application.routes.draw do
  root 'site#index'

  devise_for :users

  get 'users/show', to: 'users#show', as: 'show_user'

  get 'projects/new', to: 'projects#new'

  post 'projects/create', to: 'projects#create', as: 'create_project'

  get 'projects/:project_id/leave', to: 'projects#leave_project', as: 'leave_project'

  get 'projects/:project_id/apply', to: 'projects#add_user_to_project', as: 'apply_project'

  delete 'projects/:id', to: 'projects#destroy', as: 'destroy_project'

  get 'projects/index'

  get 'projects/index_all'

  get 'projects/index_participating'

  get 'projects/:id', to: 'projects#show', as: 'show_project'


  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
