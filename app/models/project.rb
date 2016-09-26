class Project < ApplicationRecord
	has_many :members, dependent: :destroy
	has_many :users, through: :members

	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  # accepts_nested_attributes_for :members

  def add_user user
    self.users.push(user)
  end
end
