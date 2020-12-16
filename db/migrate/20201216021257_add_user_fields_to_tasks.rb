class AddUserFieldsToTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :creator, null: false, foreign_key: {to_table: :users}
    add_reference :tasks, :assignee, foreign_key: {to_table: :users}
  end
end
