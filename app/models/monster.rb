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
end
