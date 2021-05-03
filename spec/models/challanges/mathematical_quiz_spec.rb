describe MathematicalQuiz do
  let(:mathematical_quiz) { MathematicalQuiz.new }

  it 'has a title' do
    expect(mathematical_quiz.title).to eq('Mathematical Quiz')
  end

  it 'has status not_passed' do
    expect(mathematical_quiz.status).to eq(:not_passed)
  end
end
