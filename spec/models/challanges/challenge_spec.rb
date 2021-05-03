describe Challenge do
  let(:challenge) { Challenge.new }

  it 'has a type' do
    expect(challenge.type).not_to eq nil
    expect([MathematicalQuiz, Monster]).to include(challenge.type.class)
  end
end
