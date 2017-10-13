class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.references :provider, foreign_key: {on_update: :cascade, on_delete: :restrict}
      t.string :url, null: false
      t.string :title, null: false
      t.text :description
      t.integer :genre, null: false, default: 0
      t.float :rating, null: false, default: 0
      t.integer :reviews_count, null: false, default: 0
      t.integer :ratings_count, null: false, default: 0

      t.timestamps
    end
    add_index :courses, :url, unique: true
    add_index :courses, :genre
  end
end
