class Course < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :categories
  
  validates :name, presence: true, length: { minimum: 10 }
  validates :prerequisite, presence: true, length: { minimum: 10 }
  validates :description, presence: true, length: { minimum: 30 }
  
end
