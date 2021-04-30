class Room
  MAX_COUNT = 50
  attr_reader :game, :parent_room, :title

  @@count = 0

  def initialize(game:, title:, parent_room: nil)
    @game = game
    @title = title
    @parent_room = parent_room
  end

  def create_child_rooms
    3.times do
      @@count += 1
      title = "room #{@@count}"
      room = Room.new(game: game, title: title, parent_room: self)
      child_rooms << room
    end
  end

  def child_rooms
    @child_rooms ||= []
  end

  def to_s
    title
  end
end
