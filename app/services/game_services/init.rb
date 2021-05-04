module GameServices
  class Init
    def initialize
      @prompt = TTY::Prompt.new
      @player = Player.new
    end

    def call
      welcome_message
      return player_not_ready_rsp unless ready_prompt

      @game = Game.new(@player)

      set_first_level_defaults
      set_player_name

      success_rsp
    end

    private

    attr_reader :game

    def welcome_message
      system('clear')
      puts('Welcome to our game')
      puts('Here is the instructions')
      puts('- You need to pass all rooms in your level to open the next level')
      puts('- Each room has a challenge which will be a surprise when you enter the room')
      puts('- Take care of yourself while you are playing')
    end

    def ready_prompt
      action = @prompt.select('Are you ready?', %w[Yes No], active_color: :red)
      action == 'Yes'
    end

    def set_first_level_defaults
      create_first_level
      add_level_to_game
      add_level_to_player
      create_rooms
    end

    def create_first_level
      @level1 = Level.new(number: 1)
    end

    def add_level_to_game
      @game.add_level(@level1)
    end

    def add_level_to_player
      @player.current_level = @level1
    end

    def create_rooms
      3.times do |i|
        title = "room 10#{i}"
        @level1.rooms << Room.new(title: title, level: @level1)
      end
    end

    def set_player_name
      @game.player.name = capture_player_name
    end

    def capture_player_name
      system('clear')

      @prompt.ask('What is your nick name?') do |q|
        q.required true
        q.validate /\A\w+\Z/
        q.modify   :capitalize
      end
    end

    def player_not_ready_rsp
      OpenStruct.new(success?: false, game: nil, msg: 'player is not ready')
    end

    def success_rsp
      OpenStruct.new(success?: true, game: game, msg: 'player is not ready')
    end
  end
end
