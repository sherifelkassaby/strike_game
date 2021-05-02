class Monster
  attr_reader :room, :title
  attr_accessor :status

  def initialize(room)
    @room = room
    @title = 'monster'
    @status = 'not_passed'
  end

  def choices
    %w[fight]
  end

  def pass!
    @status = 'passed'
  end

  def passed?
    @status == 'passed'
  end

  def challenge
    OpenStruct.new(title: "What is the result of multiplication #{first} and #{second}", regex: /\d+\S/)
  end
end
