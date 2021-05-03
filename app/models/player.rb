class Player
  attr_reader :hp, :game
  attr_accessor :name, :current_room, :current_level, :move

  NEXT_MOVE_MAP = {
    'room_or_level' => 'event_decision',
    'event_decision' => 'event_challenge',
    'event_challenge' => 'event_passed',
    'event_passed' => 'room_or_level'
  }.freeze

  def initialize(game:, current_level:)
    @hp = 100
    @game = game
    @current_level = current_level
    @move = { type: 'room_or_level' }
  end

  def find_next_move(move)
    NEXT_MOVE_MAP[move]
  end
end
