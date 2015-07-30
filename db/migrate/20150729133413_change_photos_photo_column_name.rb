class ChangePhotosPhotoColumnName < ActiveRecord::Migration
  def change
    change_table :photos do |t|
      t.remove :photo
      t.string :fullsize_image
    end
  end
end
