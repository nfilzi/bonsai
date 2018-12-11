class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.integer :user_id

      t.string  :name
      t.integer :age_in_months, default: 0
      t.string  :size
      t.string  :room
      t.string  :photo_url

      t.integer :care_points, default: 0
      t.boolean :favorite,    default: false
      t.timestamps
    end

    add_foreign_key :plants, :users
  end
end
