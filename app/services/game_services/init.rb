module GameServices
  class Init
    def initialize
      @prompt = TTY::Prompt.new
    end

    def call
      welcome_message
      return player_not_ready_rsp unless ready_prompt

      @game = Game.new
      set_defaults
      set_player_name

      success_rsp
    end

    private

    attr_reader :game

    def welcome_message
      system('clear')
      puts('Welcome to our game')
      puts('Here is the instructions')
      puts('If you want exit the game anytime press ^C')
    end

    def ready_prompt
      action = @prompt.select('Are you ready?', %w[Yes No], active_color: :red)
      action == 'Yes'
    end

    def set_defaults
      @game.main_room = Room.new(game: @game, title: 'main')
      @game.player = Player.new(game: @game)
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
