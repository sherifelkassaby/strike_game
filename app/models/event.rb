class Event
  def initialize(room)
    kind = [Monster, MathematicalQuiz].sample
    room.event = kind.new(room) if kind
  end
end
