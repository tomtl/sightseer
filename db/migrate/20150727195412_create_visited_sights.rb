class CreateVisitedSights < ActiveRecord::Migration
  def change
    create_table :visited_sights do |t|
      t.integer :user_id
      t.integer :sight_id
      t.timestamps
    end
  end
end
