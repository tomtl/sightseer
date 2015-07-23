class CreateSights < ActiveRecord::Migration
  def change
    create_table :sights do |t|
      t.string :name
      t.string :address
      t.integer :category_id
      t.text :description
      t.timestamps
    end
  end
end
