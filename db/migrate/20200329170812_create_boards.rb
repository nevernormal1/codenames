class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.string :link_token
      t.text :words
      t.timestamps
    end

    add_index :boards, :link_token, unique: true
  end
end
