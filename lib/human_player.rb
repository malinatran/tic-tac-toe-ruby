require_relative "player"

module TicTacToe

  class HumanPlayer < Player
    attr_accessor :marker
    
    def default_marker
      MARKERS[1]
    end
  end
end
