class Course < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  belongs_to :user
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :categories
  has_many :votes
  validates :name, presence: true, length: { minimum: 10 }, uniqueness: { case_sensitive: false }
  validates :prerequisite, presence: true, length: { minimum: 10 }
  validates :description, presence: true, length: { minimum: 30 }
  
end
