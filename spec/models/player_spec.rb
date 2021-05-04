describe Player do
  let(:level) { Level.new(number: 0) }
  let(:player) { Player.new }
  let(:game) { Game.new(player) }

  before { player.current_level = level }

  it 'has first move' do
    expect(player.move).to eq({ type: 'room_or_level' })
  end

  describe '#next_move' do
    it 'returns the next move' do
      expect(player.find_next_move('room_or_level')).to eq 'challenge_decision'
    end
  end
end
