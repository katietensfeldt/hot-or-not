class CreateHotnessSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :hotness_settings do |t|
      t.float :temp
      t.integer :units

      t.timestamps
    end
  end
end
