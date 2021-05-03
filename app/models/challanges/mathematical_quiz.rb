class MathematicalQuiz < Challenge
  attr_reader :room, :title, :first_number, :second_number

  def initialize
    @title = 'MathematicalQuiz'
    @status = 'not_passed'

    @first_number = rand(10)
    @second_number = rand(10)
  end

  def decision_choices
    ['solve it']
  end

  def property
    {
      type: :ask,
      title: "What is the result of multiplication #{first_number} and #{second_number}?",
      regex: /\d*\S/
    }
  end

  def check_pass(solution)
    solution.to_i == first_number * second_number
  end
end
