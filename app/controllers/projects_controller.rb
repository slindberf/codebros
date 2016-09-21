class ProjectsController < ApplicationController

  def new
    @project = current_user.projects.new
    @project.members.build
  end

  def create
    #hay que hacer create para que cree member (con new no se crea)
    # binding.pry
    @project = current_user.projects.create project_params
    #if @project.save
      member = current_user.members.find_by(project_id: @project.id)
      
      member.category = params[:category] #'Back' #params[:user_category]

      member.role = 'admin'
      member.save

      redirect_to show_project_path @project.id
    #else
    #  render 'projects/new'
    #end 
  end

  def show
    @project = Project.find_by(id: params[:id])
    if !(@project)
      flash[:alert] = "Error 404 project not found fucker"
      redirect_to projects_index_all_path
    end
  end

  def destroy
    @project = Project.find_by(id: params[:id])
    #binding.pry
    member = current_user.members.find_by(project_id: @project.id)
    if(member)
      if member.role == 'admin'
        @project.destroy
        flash[:notice] = "Proyecto eliminado"
        redirect_to projects_index_path
      end
    end
    flash[:alert] = "No molas, no tienes el flow Admin"
    redirect_to show_project_path @project
    
  end

  def index
    @projects = Project.where(id: current_user.members.where(role: 'admin').pluck(:project_id))
  end

  def index_all
    @projects = Project.all
  end

  def index_participating
    @projects = current_user.projects
  end

  def add_user_to_project
    @project = Project.find_by(id: params[:project_id])
    if(!(current_user.projects.find_by(id: @project.id)))

      
      @project.users.push(current_user)
      member = current_user.members.find_by(project_id: @project.id)
      member.role = 'participating'
      member.category = 'Full-stack'
      member.save
      flash[:notice] = "El admin de este grupo ha recibido tu petición. Espera pelotudo"

    else
      flash[:alert] = "Ya curras aquí pringao"
    end

    redirect_to show_project_path(@project.id)
  end

  def leave_project
    @project = Project.find_by(id: params[:project_id])
    if(current_user.projects.find_by(id: @project.id))

      member = current_user.members.find_by(project_id: @project.id)
      if (member.role == 'admin')
        flash[:alert] = "No puedes abandonar a tus amigos... traidor vete a eliminar el proyecto"
      else
        member.destroy
        flash[:notice] = "Has abandonado el grupo"
      end
    else
      flash[:alert] = "No puedes abandnar a un equipo que no perteneces. punto."
    end

    redirect_to show_project_path(@project.id)
  end

  private
    def project_params
      params.require(:project).permit(:project_type, :name, :purpose, :description)
    end
end
