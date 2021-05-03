describe Level do
  let(:level) { Level.new(number: 0) }
  let(:level1) { Level.new(number: 1, prv: level) }

  it 'has next level' do
    expect(level1.prv).to be level
  end

  describe '#completed?' do
    let!(:room) { Room.new(title: 'room 101', level: level) }
    let!(:challenge) { room.challenge }
    before { level.rooms << room }

    context 'room still not passed' do
      it 'return false' do
        expect(level.completed?).to eq false
      end
    end

    context 'all rooms passed' do
      before { challenge.pass! }

      it 'return true' do
        expect(level.completed?).to eq true
      end
    end
  end
end
