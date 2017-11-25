class CreateSensors < ActiveRecord::Migration[5.1]
  def change
    create_table :sensors do |t|
      t.string :sigfox_id, index: true, unique: true
      t.integer :fullness_pct, null: false, default: 0
    end
  end
end
