class CreateSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :seats do |t|

      t.references :trip, foreign_key: true
      
    end
  end
end
