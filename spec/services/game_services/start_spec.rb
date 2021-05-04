describe GameServices::Start, :aggregate_failures do
  let!(:level) { Level.new(number: 1) }
  let!(:room) { Room.new(title: 'room 101', level: level) }
  let!(:player) { Player.new }
  let(:game) { Game.new(player) }
  let(:level2) { Level.new(number: 2, prv: level) }
  let(:room2) { Room.new(title: 'room 201', level: level2) }
  let(:start_service) { GameServices::Start.new(game: game) }

  before do
    player.current_level = level
    level.rooms << room
  end

  subject { GameServices::Start.new(game: game).call }

  describe '#set_next_room_or_level' do
    subject(:set_next_room_or_level) { start_service.send(:set_next_room_or_level) }

    context 'Current level has only rooms' do
      let(:choices) { [{ name: room.title, value: room }, { name: 'exit', value: nil }] }

      it 'calls prompt with rooms and exit' do
        expect(start_service)
          .to receive(:prompt_select).with(title: 'Choose where would you like to go?', choices: choices)
                                     .and_return(room)
        set_next_room_or_level
      end
    end

    context 'Current level has previous level' do
      let(:choices) do
        [
          { name: room2.title, value: room2 },
          { name: 'go to the previous level', value: level },
          { name: 'exit', value: nil }
        ]
      end

      before do
        level2.rooms << room2
        player.current_level = level2
      end

      it 'calls prompt with rooms, previous level and exit' do
        expect(start_service)
          .to receive(:prompt_select).with(title: 'Choose where would you like to go?', choices: choices)
                                     .and_return(room)
        set_next_room_or_level
      end
    end

    context 'Current level has next level' do
      before do
        level.nxt = level2
        level2.rooms << room2
      end

      context 'room did not pass' do
        let(:choices) do
          [
            { name: room.title, value: room },
            { name: 'exit', value: nil }
          ]
        end

        it 'calls prompt with rooms and exit' do
          expect(start_service)
            .to receive(:prompt_select).with(title: 'Choose where would you like to go?', choices: choices)
                                       .and_return(room)
          set_next_room_or_level
        end
      end

      context 'all rooms passed' do
        let(:choices) do
          [
            { name: room.title, value: room },
            { name: 'go to the next level', value: level2 },
            { name: 'exit', value: nil }
          ]
        end

        before { room.challenge.pass! }

        it 'calls prompt with rooms, next level and exit' do
          expect(start_service)
            .to receive(:prompt_select).with(title: 'Choose where would you like to go?', choices: choices)
                                       .and_return(room)
          set_next_room_or_level
        end
      end
    end
  end

  describe '#move_to_room_or_level' do
    subject(:move_to_room_or_level) { start_service.send(:move_to_room_or_level) }

    context 'next move is level' do
      before { player.move[:value] = level2 }

      it 'updates the player level' do
        move_to_room_or_level
        expect(player.current_level).to eq level2
      end
    end

    context 'next move is room' do
      before { player.move[:value] = room }

      it 'updates the player level' do
        move_to_room_or_level
        expect(player.current_room).to eq room
      end
    end
  end

  describe '#set_next_challenge_decision' do
    subject(:set_next_challenge_decision) { start_service.send(:set_next_challenge_decision) }

    before { player.current_room = room }

    context 'room challenge passed' do
      before { room.challenge.pass! }

      it 'returns already passed challenge' do
        expect(start_service)
          .to receive(:prompt_select).with(title: 'you already passed this challenge', choices: ['go back'])
                                     .and_return(room)
        set_next_challenge_decision
      end
    end

    context 'room challenge not passed' do
      let(:challenge) { room.challenge }
      let(:title) { challenge.title }
      let(:choices) { challenge.decision_choices.concat(['go back']) }

      it 'returns the challenge decision' do
        expect(start_service)
          .to receive(:prompt_select).with(title: "You are ahead of #{title}?", choices: choices)
                                     .and_return(room)
        set_next_challenge_decision
      end
    end
  end

  describe '#move_to_challenge_decision' do
    subject(:move_to_challenge_decision) { start_service.send(:move_to_challenge_decision) }
    let(:challenge) { room.challenge }

    context 'wants to go back' do
      before { player.move[:value] = 'go back' }

      it 'updates the player move' do
        move_to_challenge_decision
        expect(player.move[:type]).to eq 'room_or_level'
      end
    end

    context 'wants to proceed' do
      before { player.move = {type: 'challenge_decision', value: challenge.decision_choices.first } }

      it 'updates the player move' do
        move_to_challenge_decision
        expect(player.move[:type]).to eq 'challenge_accepted'
      end
    end
  end
end
