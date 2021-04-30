require 'tty-prompt'
require 'require_all'

require_all './app'

game = GameServices::Init.new.call
return unless game

GameServices::Start.new.call(game: game)
