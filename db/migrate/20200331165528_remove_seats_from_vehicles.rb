class RemoveSeatsFromVehicles < ActiveRecord::Migration[5.2]
  def change
    remove_column :vehicles, :seats, :integer
  end
end
