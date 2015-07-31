class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.integer :sight_id
      t.string :photo
      t.string :thumbnail
      t.text :description
      t.timestamps
    end
  end
end
