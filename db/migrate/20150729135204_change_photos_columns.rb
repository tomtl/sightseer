class ChangePhotosColumns < ActiveRecord::Migration
  def change
    change_table :photos do |t|
      t.remove :fullsize_image, :thumbnail
      t.string :image
    end
  end
end
