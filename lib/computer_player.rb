require_relative "player"
require_relative "board"

module TicTacToe
  class ComputerPlayer < Player

    attr_reader :marker, :move

    def default_marker
      MARKERS[0]
    end

    def minimax(board, depth, current_marker, opponent_marker)
      if is_game_over?(board, opponent_marker)
        return score(board, depth, opponent_marker)
      end
  
      depth += 1
      scores = {}

      board.get_empty_cells.each do |cell|
        next_game_state = board.dup
        next_game_state.set_cell(cell, current_marker)
        scores[cell] = minimax(next_game_state, depth, switch(current_marker, opponent_marker), opponent_marker)
      end

      @move, score = best_move(current_marker, scores)
      score
    end

    def score(board, depth, opponent_marker)
      if board.winner(marker) == marker
        10 - depth
      elsif board.winner(opponent_marker) == opponent_marker
        depth - 10
      else
        0
      end 
    end

    def switch(current_marker, opponent_player)
      current_marker == marker ? opponent_player : marker
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
