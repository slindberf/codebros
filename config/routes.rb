Rails.application.routes.draw do
  root 'site#index'

  devise_for :users

  #usar namespace para que gener el path con api y v1
  namespace :api do

    namespace :v1 do

      get 'projects/index', to: 'projects#index'

      get 'projects/index_all', to: 'projects#index_all'

      get 'projects/index_participating', to: 'projects#index_participating'

    end

  end 

  get 'users/show', to: 'users#show', as: 'show_user'

  delete 'users/skills/:id', to: 'users#remove_skill', as: 'remove_skill'
  
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
