module GameServices
  class Start
    extend Errors

    def initialize(game:)
      @prompt = TTY::Prompt.new
      @room_count = 1
      @game = game
    end

    def call
      main_room_welcome_message
      assign_game_player

      game_sequence
    rescue Errors::Exit
      false
    end

    private

    def main_room_welcome_message
      puts('Welcome to the first room of the game')
    end

    def assign_game_player
      @player = @game.player
    end

    def game_sequence
      keep_playing = true
      until keep_playing == false
        system('clear')
        create_child_rooms if @player.current_room&.child_rooms&.empty?
        move_player_prompt
        meet_event_prompt
      end
    end

    def create_child_rooms
      parent_room = @player.current_room

      3.times do
        @room_count += 1
        title = "room #{@room_count}"
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
      room_chosen = @prompt.select('Choose where would like to go?', choices, active_color: :red)
      raise Errors::Exit unless room_chosen

      @player.current_room = room_chosen
    end

    def meet_event_prompt
      current_room = @player.current_room
      event = current_room.event

      return if !event || event.passed?

      choices = event.choices.concat(['go back'])
      event_choice = @prompt.select("You are ahead of #{event.title}?", choices, active_color: :red)
      return @player.current_room = current_room.parent_room if event_choice == 'go back'

      event.pass!
    end
  end
end
