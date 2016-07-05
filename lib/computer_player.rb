require_relative "player"
require_relative "board"
require_relative "constants"
require_relative "game_state"

module TicTacToe
  class ComputerPlayer < Player

    attr_reader :marker, :move

    def default_marker
      MARKERS[0]
    end

    def minimax(board, depth, current_marker, opponent_marker)
      markers = [current_marker, opponent_marker]
      if TicTacToe::is_game_over?(board, markers)
        return score(board, depth, opponent_marker)
      end
  
      depth += 1
      scores = {}

      board.get_empty_cells.each do |cell|
        board.set_cell(cell, current_marker)
        scores[cell] = minimax(board, depth, switch(current_marker, opponent_marker), opponent_marker)
        board.clear_cell(cell)
      end

      @move, score = best_move(current_marker, scores)
      score
    end

    def score(board, depth, opponent_marker)
      if TicTacToe::is_winner?(board, marker)
        10 - depth
      elsif TicTacToe::is_winner?(board, opponent_marker)
        depth - 10
      else
        0
      end 
    end

    def switch(current_marker, opponent_player)
      current_marker == marker ? opponent_player : marker
    end

    def best_move(current_marker, scores)
      if current_marker == MARKERS[0]
        scores.max_by {|k, v| v}
      else
        scores.min_by {|k, v| v}
      end
    end
  end
end
