class Game
  attr_reader :player
  attr_accessor :rooms, :main_room

  def initialize
    set_main_room
    set_player
  end

  def start
    player.game_loop
  end

  private

  def set_player
    @player = Player.new(game: self)
  end

  def set_main_room
    @main_room = Room.new(game: self, title: 'main')
  end
end
