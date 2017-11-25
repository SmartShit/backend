class CreateSumps < ActiveRecord::Migration[5.1]
  def change
    create_table :sumps do |t|
      t.references :sensor, null: false

      t.float :latitude, null: false
      t.float :longitude, null: false

      t.string :phone, null: false
      t.string :name, null: false
      t.string :address_street, null: false
      t.string :address_city, null: false
    end
  end
end
