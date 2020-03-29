class CreateGuesses < ActiveRecord::Migration[6.0]
  def change
    create_table :guesses do |t|
      t.references :board, index: true
      t.string :guess
      t.integer :turn
    end
  end
end
