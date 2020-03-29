class CreateClues < ActiveRecord::Migration[6.0]
  def change
    create_table :clues do |t|
      t.references :board, index: true
      t.string :clue
      t.integer :number
      t.integer :turn
    end
  end
end
