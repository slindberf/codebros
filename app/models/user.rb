class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :skill
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
	has_many :projects, through: :members
  has_many :members, dependent: :destroy
  has_many :skill_users
  has_many :skills, through: :skill_users

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name, presence: true

  def skill=(skill)
    self.skills << Skill.where(name: skill, user_id: current_user.id).first_or_create
  end
end
