class AddUserIdentifiersToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :opponent, :text
    add_column :games, :host, :text
  end
end
