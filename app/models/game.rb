class Game
  attr_accessor :main_room, :player

  def initialize(player)
    @player = player
  end

  def levels
    @levels ||= []
  end

  def add_level(level)
    levels << level
  end
end
