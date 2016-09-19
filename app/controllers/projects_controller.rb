class ProjectsController < ApplicationController
  def new
    
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new project_params
    if @project.save
      redirect_to show_project_path @project.id
    else
      render 'projects/new'
    end 
  end

  def show
    @project = current_user.projects.find_by(id: params[:id])
  end

  def destroy
  end

  def index
    @projects = current_user.projects
  end

  def index_all
  end

  def index_participating
  end

  private
    def project_params
      params.require(:project).permit(:project_type, :name, :purpose, :description)
    end
end
