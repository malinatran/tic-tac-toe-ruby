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

      user_interface.display_board(board.grid)
      move = user_interface.select_move
    end
  end
end
