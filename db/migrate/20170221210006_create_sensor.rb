class CreateSensor < ActiveRecord::Migration[5.0]
  def change
  	create_table :sensors do |t|
      t.string :name
  	  t.integer :value
  	  t.datetime :dateMeasured
    end
  end
end