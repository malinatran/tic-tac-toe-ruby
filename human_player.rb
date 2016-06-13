require "./player"

module TicTacToe

  class HumanPlayer < Player
    attr_reader :identity
    
    def default_identity
      "O"
    end
  end
end
