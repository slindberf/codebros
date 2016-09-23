class Api::V1::ProjectsController < ApplicationController

  #devuelve todos los proyectos
  def index_all
    #hay que añadir paginación para que no devuelva todos los proyectos
    projects = Project.all
    render json: projects
  end

  #devuelve los proyectos en los que participa el current_user
  def index_participating
    projects = current_user.projects
    render json: projects
  end

  #devuelve los proyectos creados por el current_user
  def index
    projects = current_user.admin_projects
    render json: projects
  end

  def apply_project
    project = Project.find_by(id: params[:project_id])
    if project
      if !(current_user.projects.find_by(id: project.id))
        project.add_user(current_user)
        member = current_user.members.find_by(project_id: project.id)
        category =  params[:data]
        member.edit_attr!('in process', category)
        #member creado a partir de apply (201)
        render status: 200
      else
        #ya existe el member del usuario
        render status: 400
      end
    else
      #project no encontrado
      render status: 404 
    end
  end

  def leave_project
    project = Project.find_by(id: params[:project_id])
    if project
      member = current_user.members.find_by(project_id: project.id)
      if member
        if (member.admin?)
          render status: 400
        else
          member.destroy
          #member eliminado
          render status: 200
        end
      else
        render status: 400
      end
    else
      #project no encontrado
      render status: 404
    end
  end

end

