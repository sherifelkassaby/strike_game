class Player
  attr_reader :hp, :game
  attr_accessor :name, :current_room

  def initialize(game:)
    @hp = 100
    @game = game
    @current_room = game.main_room
  end
end
