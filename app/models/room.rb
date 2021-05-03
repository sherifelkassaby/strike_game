class Room
  attr_reader :title, :level
  attr_accessor :challenge

  def initialize(title:, level:)
    @title = title
    @level = level

    set_challenge
  end

  def passed?
    challenge.passed?
  end

  def to_s
    title
  end

  def set_challenge
    @challenge = Challenge.new.type
  end
end
