class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.timestamps
      t.string :value
    end
  end
end
