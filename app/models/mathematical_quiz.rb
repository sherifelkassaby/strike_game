class MathematicalQuiz
  attr_reader :room, :title

  def initialize(room)
    @room = room
    @title = 'MathmeticalQuiz'
    @status = 'not_passed'
  end

  def choices
    ['solve it']
  end

  def pass!
    @status = 'passed'
  end

  def passed?
    @status == 'passed'
  end
end
