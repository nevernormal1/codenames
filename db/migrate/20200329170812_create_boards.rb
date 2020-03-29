class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.string :giver_link_token
      t.string :guesser_link_token
      t.text :words
      t.integer :assassin
      t.text :blue
      t.text :red

      t.timestamps
    end

    add_index :boards, :giver_link_token, unique: true
    add_index :boards, :guesser_link_token, unique: true
  end
end
