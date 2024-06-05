class Player
  include PlayerNameGeneration

  attr_accessor :name

  def initialize(name = nil)
    @name = name || generate_player_name
  end
end
