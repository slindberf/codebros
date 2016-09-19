class ProjectsController < ApplicationController
  def new

    @project = current_user.projects.new
  end

  def create
    @project = Project.new project_params
    if @project.save
      member = current_user.members.create(project_id: @project.id, category: 'back', role: 'admin')
      redirect_to show_project_path @project.id
    else
      render 'projects/new'
    end 
  end

  def show
    @project = Project.find_by(id: params[:id])
  end

  def destroy
    @project = current_user.projects.find_by(id: params[:id])
    puts @project.inspect
    role = current_user.members.where(project_id: @project.id)[0].role
    if role == 'admin'
      @project.destroy
    else
      render :text => "No molas, no tienes el flow Admin"
    end
  end

  def index
    @projects = current_user.projects
  end

  def index_all
    @projects = Project.all
  end

  def index_participating
  end

  private
    def project_params
      params.require(:project).permit(:project_type, :name, :purpose, :description)
    end
end
