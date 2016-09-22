class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #attr_accessor :skill
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
	has_many :projects, through: :members
  has_many :members, dependent: :destroy
  has_many :skill_users, dependent: :destroy
  has_many :skills, through: :skill_users





	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name, presence: true

  def skill=(skills)
    skills.split(',').each do |skill|
      #self = current_user(User) skills(relación de user.skills(activeRecords))
      skill_to_add = Skill.where(name: skill).first_or_create
       
      self.skills.push(skill_to_add)
    end
  end

  def admin_projects
    Project.where(id: self.members.where(role: 'admin').pluck(:project_id))
  end

end
