class AddPictureToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :picture, :string
  end
end
