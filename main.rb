require 'tty-prompt'
require 'require_all'
require 'ostruct'

require_all './app'

game_init_result = GameServices::Init.new.call

unless game_init_result.success?
  puts(game_init_result.msg)
  puts('Terminating the game')

  return
end

GameServices::Start.new(game: game_init_result.game).call
