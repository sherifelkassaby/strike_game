class MathematicalQuiz
  attr_reader :room, :title, :first_number, :second_number

  def initialize(room)
    @room = room
    @title = 'MathematicalQuiz'
    @status = 'not_passed'

    srand
    @first_number = rand(100)
    @second_number = rand(100)
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

  def challenge
    { title: "What is the result of multiplication #{first_number} and #{second_number}?", regex: /\d+\S/ }
  end

  def check_solution(solution)
    solution == first_number * second_number
  end
end
