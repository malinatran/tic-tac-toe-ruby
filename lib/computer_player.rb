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
        board.set_cell(cell, current_marker)
        scores[cell] = minimax(board, depth, switch(current_marker, opponent_marker), opponent_marker)
        board.clear_cell(cell)
      end

      @move, score = best_move(current_marker, scores)
      score
    end

    def score(board, depth, opponent_marker)
      if is_winner?(board, marker)
        10 - depth
      elsif is_winner?(board, opponent_marker)
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
        if is_winner?(board, player_marker)
          return true
        end
      end

      false
    end

    def is_winner?(board, current_marker)
      if board.is_either_diagonal_filled?(current_marker)
        return true
      end

      board.size.times do |n|
        if board.is_row_filled?(n, current_marker) || board.is_column_filled?(n, current_marker)
          return true
        end
      end

      false
    end
  end
end
