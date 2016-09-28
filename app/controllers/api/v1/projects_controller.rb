class Api::V1::ProjectsController < ApplicationController
  
  #devuelve todos los proyectos
  def index_all
    #hay que añadir paginación para que no devuelva todos los proyectos
    projects = Project.all.paginate(:page => params[:page])
    render json: projects
  end

  #devuelve los proyectos en los que participa el current_user
  def index_participating
    projects = current_user.projects.paginate(:page => params[:page])
    render json: projects
  end

  #devuelve los proyectos creados por el current_user
  def index
    projects = current_user.admin_projects.paginate(:page => params[:page])
    render json: projects
  end

  def apply
    project = Project.find_by(id: params[:id])
    if project
      if !(current_user.projects.find_by(id: project.id))
        project.add_user(current_user)
        member = current_user.members.find_by(project_id: project.id)
        category =  params[:category]
        member.edit_attr!('candidate', category)
        #member creado a partir de apply (201)
        render json: {error: 'ok'}, status: 200
      else
        #ya existe el member del usuario
        render json: {error: 'ya eres member'}, status: 400
      end
    else
      #project no encontrado
      render json: {error: 'project not found'}, status: 404 
    end
  end

  def leave
    project = Project.find_by(id: params[:id])
    if project
      member = current_user.members.find_by(project_id: project.id)
      if member
        if (member.admin?)
          render json: {error: 'eres admin'}, status: 400
        else
          member.destroy
          #member eliminado
          render json: {error: 'ok'}, status: 200
        end
      else
        render json: {error: 'no eres member'}, status: 400
      end
    else
      #project no encontrado
      render json: {error: 'project not found'}, status: 404
    end
  end

end

