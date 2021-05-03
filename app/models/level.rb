class Level
  attr_reader :number
  attr_accessor :nxt, :prv

  def initialize(number:, nxt: nil, prv: nil)
    @number = number
    @nxt = nxt
    @prv = prv
  end

  def rooms
    @rooms ||= []
  end

  def completed?
    rooms.all?(&:passed?)
  end

  private

  def to_s
    "Level #{number}"
  end
end
