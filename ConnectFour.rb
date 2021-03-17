require_relative 'lib/game.rb'
require_relative 'lib/board.rb'
require_relative 'lib/player.rb'
require_relative 'lib/cell.rb'

class ConnectFour
    def initialize
        game = Game.new
        game.launch
    end
end

ConnectFour.new