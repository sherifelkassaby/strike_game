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

        # next_move = next_move_decision
        # make_next_move(next_move)
        case @player.move[:type]
        when 'room_or_level'
          send("#{@player.move[:type]}_move_prompt")
          send("#{@player.move[:type]}_move")
          # @player.move[:type] = @player.find_next_move(@player.move[:type])
        when 'event_decision'
          event_decision_move_prompt
          event_decision_move
          # @player.move[:type] = @player.find_next_move(@player.move[:type])
        when 'event_challenge'
          event_challenge_move_prompt
          event_challenge_move
          # @player.move[:type] = @player.find_next_move(@player.move[:type])
        when 'event_passed'
          event_passed_move_prompt
          event_passed_move
          # @player.move[:type] = @player.find_next_move(@player.move[:type])
        end

        # event_choice = meet_event_prompt
        # solution = event_challenge_prompt
        # pass_event if solution
      end
    end

    # def check_
    #   @player.current_room&.child_rooms&.empty?
    # end

    # def create_child_rooms
    #   parent_room = @player.current_room
    #   room_count ||= 0

    #   3.times do
    #     room_count += 1
    #     title = "room #{room_count}"
    #     room = Room.new(game: @game, title: title, parent_room: parent_room)
    #     parent_room.child_rooms << room
    #   end
    # end

    def room_or_level_move_prompt
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

    def room_or_level_move
      next_move = @player.move[:value]
      raise Errors::Exit unless next_move

      if next_move.is_a? Room
        @player.current_room = next_move
      elsif next_move.is_a? Level
        @player.current_level = next_move
      end
      @player.move = { type: @player.find_next_move(@player.move[:type]) }
    end

    def event_decision_move_prompt
      current_room = @player.current_room
      event = current_room.event

      return if !event || event.passed?

      choices = event.choices.concat(['go back'])
      choice = @prompt.select("You are ahead of #{event.title}?", choices, active_color: :red)
      @player.move[:value] = choice
    end

    def event_decision_move
      return @player.move = { type: 'room_or_level' } if @player.move[:value] == 'go back'
      @player.move = { type: @player.find_next_move(@player.move[:type]) }
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
