class Member < ApplicationRecord
  belongs_to :user
  belongs_to :project

  after_destroy :cleanup_project

  def edit_attr! role, category
    self.role = role
    self.category = category
    self.save
  end

  def admin?
    self.role == 'admin'
  end

  private

  def cleanup_project
  	if(self.role == 'admin')
  		(Project.find_by(id: self.project_id)).destroy
  	end
  end
end
