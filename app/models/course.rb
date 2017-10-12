class Course < ApplicationRecord
  belongs_to :provider


end

# t.string :url, null: false
# t.string :title, null: false
# t.text :description
# t.integer :genre, null: false
# t.float :rating, null: false, default: 0
# t.integer :reviews_counter, null: false, default: 0
