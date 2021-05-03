class Monster < Challenge
  attr_reader :room, :title
  attr_accessor :status

  STATUSES = %w[not_passed passed].freeze

  def initialize
    @title = 'monster'
    @status = :not_passed
  end

  def decision_choices
    %w[fight]
  end

  def property
    {
      type: :select,
      title: 'Choose your move?',
      choices: [
        'Drop Kick',
        'Pocket Sand',
        'Right Hook',
        'Left Hook'
      ]
    }
  end

  def check_pass(_selection)
    [true, false].sample
  end
end
