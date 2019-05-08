class AddPrerequisiteToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :prerequisite, :string
  end
end
