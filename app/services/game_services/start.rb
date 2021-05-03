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

      while keep_playing
        system('clear')
        set_next_move
        execute_next_move
      end
    end

    def set_next_move
      send("set_next_#{@player.move[:type]}")
    end

    def execute_next_move
      send("move_to_#{@player.move[:type]}")
    end

    def set_next_room_or_level
      current_level = @player.current_level
      prv_level = current_level&.prv
      nxt_level = current_level&.nxt

      choices = current_level.rooms.map { |room| { name: room.title, value: room } }
      choices << { name: 'go to the previous level', value: prv_level } if prv_level
      choices << { name: 'go to the next level', value: nxt_level } if nxt_level && current_level.completed?
      choices << { name: 'exit', value: nil }

      puts('There are rooms ahead of you')
      choice = @prompt.select('Choose where would you like to go?', choices, active_color: :red)
      @player.move[:value] = choice
    end

    def move_to_room_or_level
      next_move = @player.move[:value]
      raise Errors::Exit unless next_move

      if next_move.is_a? Room
        @player.current_room = next_move
        @player.move = { type: @player.find_next_move(@player.move[:type]) }
      elsif next_move.is_a? Level
        @player.current_level = next_move
        @player.move = { type: 'room_or_level' }
      end
    end

    def set_next_challenge_decision
      current_room = @player.current_room
      challenge = current_room.challenge

      choices = challenge.passed? ? [] : challenge.decision_choices

      question = challenge.passed? ? 'you already passed this challenge' : "You are ahead of #{challenge.title}?"

      choice = @prompt.select(question, choices.concat(['go back']), active_color: :red)
      @player.move[:value] = choice
    end

    def move_to_challenge_decision
      return @player.move = { type: 'room_or_level' } if @player.move[:value] == 'go back'

      @player.move = { type: @player.find_next_move(@player.move[:type]) }
    end

    def set_next_challenge_accepted
      challenge = @player.current_room.challenge
      property  = challenge.property

      output = next_challenge_accepted_prompt(property)

      check = challenge.check_pass(output)
      @player.move[:value] = check
    end

    def next_challenge_accepted_prompt(property)
      case property[:type]
      when :ask
        @prompt.ask(property[:title]) do |q|
          q.required true
          q.validate property[:regex]
        end
      when :select
        @prompt.select(property[:title], property[:choices], active_color: :red)
      end
    end

    def move_to_challenge_accepted
      @player.move = { type: @player.find_next_move(@player.move[:type]), value: @player.move[:value] }
    end

    def set_next_challenge_passed
      if @player.move[:value]
        puts('you have passed it')
      else
        puts("Oh my God You haven't passed it plz try again later")
      end

      sleep(2)
    end

    def move_to_challenge_passed
      @player.current_room.challenge.pass! if @player.move[:value]
      @player.move = { type: @player.find_next_move(@player.move[:type]) }
      create_next_level if @player.current_level.completed?
    end

    def create_next_level
      current_level = @player.current_level
      next_level = Level.new(number: current_level.number + 1, prv: current_level)
      current_level.nxt = next_level
      @game.add_level(next_level)
      create_rooms(next_level)
    end

    def create_rooms(level)
      3.times do |i|
        title = "room #{level.number}0#{i}"
        level.rooms << Room.new(title: title, level: level)
      end
    end
  end
end
