require_relative "constants"
require_relative "player"

module TicTacToe
  class HumanPlayer < Player

    attr_accessor :marker

    def default_marker
      MARKER[:human]
    end

    def make_move(params)
      user_interface = params[:user_interface]
      board          = params[:board]

      user_interface.get_move(board.grid)
    end
  end
end
