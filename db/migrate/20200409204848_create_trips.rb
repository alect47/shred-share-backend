class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :origin
      t.string :destination
      t.boolean :round_trip, default: true

      t.timestamps
    end
  end
end
