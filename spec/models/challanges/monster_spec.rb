describe Monster do
  let(:monster) { Monster.new }

  it 'has a title' do
    expect(monster.title).to eq('monster')
  end

  it 'has status not_passed' do
    expect(monster.status).to eq(:not_passed)
  end
end
