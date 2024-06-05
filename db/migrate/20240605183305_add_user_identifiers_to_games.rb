class AddUserIdentifiersToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :opponent_uuid, :text
    add_column :games, :host_uuid, :text
  end
end
