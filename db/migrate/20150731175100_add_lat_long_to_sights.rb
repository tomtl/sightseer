class AddLatLongToSights < ActiveRecord::Migration
  def change
    change_table :sights do |t|
      t.float :latitude
      t.float :longitude
    end
  end
end
