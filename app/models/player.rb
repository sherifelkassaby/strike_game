class Player
  attr_reader :hp, :game
  attr_accessor :name, :current_room

  @@moves = [
    { name: 'Drop Kick', damage: 40 },
    { name: 'Pocket Sand', damage: 50 },
    { name: 'Right Hook', damage: 20 },
    { name: 'Left Hook', damage: 70 }
  ]

  def initialize(game:)
    @hp = 100
    @game = game
    @current_room = game.main_room
  end
end
