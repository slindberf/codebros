class ProjectsController < ApplicationController

  def new
    @project = current_user.projects.new
    @project.members.build
  end

  def create

    #PREGUNTAR
    #cómo dejarlo con el create! devuelve

    #hay que hacer create para que cree member (con new no se crea)
    # binding.pry
    @project = current_user.projects.create project_params
    #if @project.save
    if(@project)
      member = current_user.members.find_by(project_id: @project.id)
      member.edit_attr!('admin', params[:category])
      @flash[:notice] = 'Project created successfully'
      redirect_to show_project_path @project.id
    else
      render 'projects/new'
    end 
  end

  def show
    @project = Project.find_by(id: params[:id])
    if (@project)
      admin = User.find_by(id: @project.members.where(role: 'admin').pluck(:user_id))
      @name = admin.name
    else
      flash[:alert] = "Error 404 project not found."
      redirect_to projects_index_all_path
    end
    
  end

  def destroy
    @project = Project.find_by(id: params[:id])
    #binding.pry
    member = current_user.members.find_by(project_id: @project.id)
    if(member)
      if member.admin?
        @project.destroy
        flash[:notice] = "Your project has been deleted"
        redirect_to projects_index_path
      end
    end
    flash[:alert] = "You don't have the admin rights to delete this project."
    redirect_to show_project_path @project
    
  end

  def index
    @projects = current_user.admin_projects
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
      @project.add_user(current_user)
      member = current_user.members.find_by(project_id: @project.id)
      #hay que añadir el campo select 
      #'in process'
      member.edit_attr!('participating', 'Full-stack')
      flash[:notice] = "Your request has been sent to the admin's project."
    else
      flash[:alert] = "You have already applied to this project."
    end
    redirect_to show_project_path(@project.id)
  end

  def leave_project
    @project = Project.find_by(id: params[:project_id])
    if(current_user.projects.find_by(id: @project.id))
      member = current_user.members.find_by(project_id: @project.id)
      if (member.admin?)
        flash[:alert] = "To delete a project you must click the delete button."
      else
        member.destroy
        flash[:notice] = "You have left from this project."
      end
    else
      flash[:alert] = "You can't leave this project. Do you want to participate? Apply to the project."
    end
    redirect_to show_project_path(@project.id)
  end

  private
    def project_params
      params.require(:project).permit(:project_type, :name, :purpose, :description)
    end
end
