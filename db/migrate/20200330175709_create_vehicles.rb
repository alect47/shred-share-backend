class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :make
      t.string :model
      t.string :year
      t.integer :seats
      t.boolean :fourwd_or_awd, default: false
      t.boolean :snow_tires, default: false

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
