class Course < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :categories
end
