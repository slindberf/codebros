class ProjectsController < ApplicationController

  before_action :find_project, only: [:show, :destroy]

  def new
    @project = current_user.projects.new
    @project.members.build
  end

  def create
    @project = current_user.projects.create project_params
    if(@project)
      member = current_user.members.find_by(project_id: @project.id)
      member.edit_attr!('admin', params[:category])
      flash[:notice] = 'Project created successfully'
      redirect_to show_project_path @project.id
    else
      render 'projects/new'
    end 
  end

  def show
    if (@project)
      @admin = User.find_by(id: @project.members.where(role: 'admin').pluck(:user_id))
      member = current_user.members.find_by(project_id: @project.id)
      @users = @project.users 
      if !member 
        @role = 'future_member' #apply
      elsif current_user == @admin
        @role = 'admin' #delete
      else 
        @role = 'candidate' #leave
      end
    else
      flash[:alert] = "Error 404 project not found."
      redirect_to projects_index_all_path
    end
    
  end

  def destroy
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
    @projects = current_user.admin_projects.paginate(:page => params[:page])
  end

  def index_all
    @projects = Project.paginate(:page => params[:page])
    #@projects = Project.all
  end

  def index_participating
    @projects = current_user.projects.paginate(:page => params[:page])
  end

  private
    def project_params
      params.require(:project).permit(:project_type, :name, :purpose, :description)
    end

    def find_project
      @project = Project.find_by(id: params[:id])
    end
end
