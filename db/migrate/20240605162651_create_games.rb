class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.text :name
      t.text :opponent_choice
      t.text :host_choice

      t.timestamps
    end
  end
end
