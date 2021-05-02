module GameServices
  class Start
    extend Errors

    def initialize(game:)
      @prompt = TTY::Prompt.new
      @room_count = 1
      @game = game
      @player = @game.player
    end

    def call
      main_room_welcome_message

      game_sequence
    rescue Errors::Exit
      false
    end

    private

    def main_room_welcome_message
      puts('Welcome to the first room of the game')
    end

    def game_sequence
      keep_playing = true
      until keep_playing == false
        system('clear')
        create_child_rooms if @player.current_room&.child_rooms&.empty?
        move_player_prompt
        next unless @player.current_room.event

        event_choice = meet_event_prompt
        next unless event_choice != 'go back'

        solution = event_challenge_prompt
        pass_event if solution
      end
    end

    def create_child_rooms
      parent_room = @player.current_room
      room_count ||= 0

      3.times do
        room_count += 1
        title = "room #{room_count}"
        room = Room.new(game: @game, title: title, parent_room: parent_room)
        parent_room.child_rooms << room
      end
    end

    def move_player_prompt
      current_room = @player.current_room
      parent_room = current_room&.parent_room
      choices = current_room.child_rooms.map { |room| { name: room.title, value: room } }
      choices << { name: 'go back', value: parent_room } if parent_room
      choices << { name: 'exit', value: nil }

      puts('There are rooms ahead of you')
      room_chosen = @prompt.select('Choose where would you like to go?', choices, active_color: :red)
      raise Errors::Exit unless room_chosen

      @player.current_room = room_chosen
    end

    def meet_event_prompt
      current_room = @player.current_room
      event = current_room.event

      return if !event || event.passed?

      choices = event.choices.concat(['go back'])
      event_choice = @prompt.select("You are ahead of #{event.title}?", choices, active_color: :red)
      @player.current_room = current_room.parent_room if event_choice == 'go back'

      event_choice
    end

    def event_challenge_prompt
      event = @player.current_room.event
      challenge = event.challenge

      solution = @prompt.ask(challenge[:title]) do |q|
        q.required true
        q.validate challenge[:regex]
      end
      check = event.check_solution(solution)
      puts "#######", check
      sleep(10)
    end

    def pass_event
      puts('you have passed it')
      sleep(2)
      @player.current_room.event.pass!
    end
  end
end
