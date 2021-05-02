class Room
  MAX_COUNT = 50
  attr_reader :game, :parent_room, :title, :level
  attr_accessor :event

  def initialize(game:, title:, parent_room: nil)
    @game = game
    @title = title
    unless parent_room
      @level = 0
      return
    end

    @level = parent_room.level + 1

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
