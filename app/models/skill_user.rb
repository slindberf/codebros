class SkillUser < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  validates :name, presence: true
end
