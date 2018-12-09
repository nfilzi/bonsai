class CreateCareMoments < ActiveRecord::Migration[5.2]
  def change
    create_table :care_moments do |t|
      t.integer :plant_id
      t.string  :code
      t.integer :points, default: 0
      t.date    :date

      t.timestamps
    end

    add_foreign_key :care_moments, :plants
  end
end
