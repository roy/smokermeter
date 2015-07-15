class CreateThermometers < ActiveRecord::Migration
  def change
    create_table :thermometers do |t|
      t.references :barbecue, index: true, foreign_key: true
      t.string :location

      t.timestamps null: false
    end
  end
end
