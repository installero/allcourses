class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.references :provider, foreign_key: true
      t.string :url
      t.string :title
      t.text :description
      t.integer :genre
      t.float :rating
      t.integer :reviews_counter

      t.timestamps
    end
    add_index :courses, :url, unique: true
    add_index :courses, :title, unique: true
  end
end
