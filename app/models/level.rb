class Level
  attr_reader :number, :nxt, :prv

  def initialize(number, nxt = nil, prv = nil)
    @number = number
    @nxt = nxt
    @prv = prv
  end

  def rooms
    @rooms ||= []
  end

  def completed?
    # rooms.any? { |room| room.status == 'not_passed' }
    true
  end

  private

  def to_s
    "Level #{number}"
  end
end
