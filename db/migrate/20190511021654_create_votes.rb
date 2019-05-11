class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :like
      t.integer :dislike
      t.integer :user_id
      t.integer :course_id

      t.timestamps
    end
  end
end
