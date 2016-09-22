class UsersController < ApplicationController

  def show
  end

  def remove_skill
    current_user.skills.find_by(id: params[:id]).destroy
    flash[:notice] = 'Skill eliminada'
    redirect_to show_user_path
  end
 

end
