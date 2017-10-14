class AddUserToCourse < ActiveRecord::Migration[5.1]
  def change
    add_reference :courses, :user, foreign_key:  {on_update: :cascade, on_delete: :restrict}
  end
end
