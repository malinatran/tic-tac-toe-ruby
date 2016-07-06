require_relative "constants"
require_relative "player"

module TicTacToe
  class HumanPlayer < Player

    attr_accessor :marker
    
    def default_marker
      MARKER[:human]
    end
  end
end
