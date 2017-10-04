class CreateProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :providers do |t|
      t.string :title
      t.string :url

      t.timestamps
    end
    add_index :providers, :url, unique: true
  end
end
