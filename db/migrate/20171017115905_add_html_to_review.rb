class AddHtmlToReview < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :html, :text
  end
end
