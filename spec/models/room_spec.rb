describe Room do
  let(:level) { Level.new(number: 0) }
  let(:room) { Room.new(title: 'room 101', level: level) }

  it 'has challenge' do
    expect(room.challenge).not_to eq nil
  end
end
