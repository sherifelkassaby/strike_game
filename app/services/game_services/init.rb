module GameServices
  class Init
    def initialize
      @prompt = TTY::Prompt.new
    end

    def call
      welcome_message
      ready = ready_prompt

      return false unless ready

      game = Game.new
      player_name(game.player)
      game
    end

    private

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

    def player_name(player)
      system('clear')
      name = @prompt.ask('What is your nick name?') do |q|
        q.required true
        q.validate /\A\w+\Z/
        q.modify   :capitalize
      end

      player.name = name
    end
  end
end
