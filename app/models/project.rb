class Project < ApplicationRecord
	has_many :members, dependent: :destroy
	has_many :users, through: :members

	# accepts_nested_attributes_for :members

  self.per_page = 2

  def add_user user
    self.users.push(user)
  end
end
