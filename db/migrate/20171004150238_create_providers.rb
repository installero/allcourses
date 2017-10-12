class CreateProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :providers do |t|
      t.string :title, null: false
      t.string :url, null: false

      t.timestamps
    end
    add_index :providers, :url, unique: true
  end
end
