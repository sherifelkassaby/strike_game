class Room
  attr_reader :title, :level
  attr_accessor :event

  def initialize(title:, level:)
    @title = title
    @level = level

    create_event
  end

  def to_s
    title
  end

  def create_event
    Event.new(self)
  end
end
