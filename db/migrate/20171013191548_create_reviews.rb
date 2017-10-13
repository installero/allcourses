class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: {on_update: :cascade, on_delete: :restrict}
      t.references :course, foreign_key: {on_update: :cascade, on_delete: :cascade}
      t.integer :rating
      t.text :text

      t.timestamps
    end
  end
end
