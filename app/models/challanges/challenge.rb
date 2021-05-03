class Challenge
  attr_reader :type

  def initialize
    @type = [Monster, MathematicalQuiz].sample.new
  end

  def pass!
    @status = 'passed'
  end

  def passed?
    @status == 'passed'
  end
end
