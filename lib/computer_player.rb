require_relative "player"
require_relative "board"

module TicTacToe
  class ComputerPlayer < Player

    attr_reader :marker, :selected_move

    def default_marker
      MARKERS[0]
    end

    def minimax(board, current_marker, opponent_marker)
      if is_game_over?(board, opponent_marker)
        return score(board, opponent_marker)
      end

      scores = {}
      moves = board.get_empty_cells

      moves.each do |move|
        board_copy = board.dup
        board_copy.set_cell(move, current_marker)
        scores[move] = minimax(board_copy, switch(current_marker), switch(opponent_marker))
      end

      @selected_move, best_score = best_move(current_marker, scores)
      best_score
    end

    def score(board, opponent_marker)
      if board.winner(marker) == marker
        10
      elsif board.winner(opponent_marker) == opponent_marker
        -10
      else
        0
      end 
    end

    def switch(current_marker)
      current_marker == "X" ? "O" : "X"
    end

    def best_move(current_marker, scores)
      if current_marker == "X"
        scores.max_by {|k, v| v}
      else
        scores.min_by {|k, v| v}
      end
    end

    def is_game_over?(board, opponent_marker)
      draw?(board, opponent_marker) || win?(board, opponent_marker)
    end

    private

    def draw?(board, opponent_marker)
      board.is_grid_filled? && !win?(board, opponent_marker)
    end

    def win?(board, opponent_marker)
      player_markers = [marker, opponent_marker]

      player_markers.each do |player_marker|
        if !board.winner(player_marker).nil?
          return true
        end
      end

      false
    end
  end
end
