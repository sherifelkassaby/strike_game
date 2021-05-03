describe Game do
  let(:game) { Game.new }
  let(:level) { Level.new(number: 0) }

  it 'has levels' do
    expect(game.levels.count).to eq 0
  end

  describe '#add_level' do
    it 'adds level to the game' do
      game.add_level(level)
      expect(game.levels.count).to eq 1
    end
  end
end
