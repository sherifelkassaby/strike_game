module GameServices
  class Start
    @@prompt = TTY::Prompt.new

    def call(game:)
      main_room_welcome_message
      @player = game.player

      game_sequence
    end

    def main_room_welcome_message
      puts('Welcome to the first room of the game')
    end

    def game_sequence
      keep_playing = true
      until keep_playing == false
        system('clear')
        create_child_rooms(@player.current_room)
        move_prompt
      end
    end

    def create_child_rooms(parent_room)
      parent_room.create_child_rooms
    end

    def move_prompt
      choices = @player.current_room.child_rooms.map { |room| { name: room.title, value: room } }

      @@prompt.select('Choose what is your next move?', choices, active_color: :red)
    end
  end
end
