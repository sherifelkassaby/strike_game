describe GameServices::Init, :aggregate_failures do
  subject { GameServices::Init.new.call }

  context 'player is not ready' do
    before { allow_any_instance_of(GameServices::Init).to receive(:ready_prompt).and_return false }

    it 'terminates the application' do
      expect(subject.success?).to eq false
    end
  end

  context 'player is ready' do
    let(:player) { Player.new }
    let(:game) { Game.new(player) }

    before do
      allow_any_instance_of(GameServices::Init).to receive(:ready_prompt).and_return true
      allow_any_instance_of(GameServices::Init).to receive(:capture_player_name).and_return 'example'
      allow(Game).to receive(:new).and_return(game)
    end

    it 'init the game' do
      expect(subject.success?).to eq true
      expect(game.levels.count).to eq 1
      expect(game.levels.first.rooms.count).to eq 3
    end
  end
end
