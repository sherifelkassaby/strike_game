class Room
  MAX_COUNT = 50
  attr_reader :game, :parent_room, :title
  attr_accessor :event

  def initialize(game:, title:, parent_room: nil)
    @game = game
    @title = title
    @parent_room = parent_room
    return unless parent_room

    create_event
  end

  def child_rooms
    @child_rooms ||= []
  end

  def to_s
    title
  end

  def create_event
    Event.new(self)
  end
end
