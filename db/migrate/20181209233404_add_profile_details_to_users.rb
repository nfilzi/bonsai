class AddProfileDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname,    :string
    add_column :users, :level,       :integer, default: 0
    add_column :users, :care_points, :integer, default: 0
  end
end
