require "pry"
require_relative "player"
require_relative "board"

module TicTacToe

  class ComputerPlayer < Player
    attr_reader :marker

    def default_marker
      MARKERS[0]
    end

    def request_move(board, opponent_marker)
      moves = board.get_empty_cells
      scores = rank_moves(board, moves, opponent_marker)
      select_optimal_move(scores)
    end

    def rank_moves(board, moves, opponent_marker)
      scores = {}

      moves.each do |move|
        if is_winning_move?(board, move, marker)
          scores[move] = 15
        elsif is_winning_move?(board, move, opponent_marker)
          scores[move] = -15
        else
          scores[move] = 0
        end
      end

      scores
    end

    def select_optimal_move(scores)
      unless scores.key(15).nil?
        return scores.key(15)
      end

      unless scores.key(0).nil?
        return scores.key(0)
      end
    end

    def is_winning_move?(board, move, marker)
      x = move[:x]
      y = move[:y]
      board.set_cell(move, marker)

      if board.is_row_filled?(x, marker) || board.is_column_filled?(y, marker) || board.is_either_diagonal_filled?(marker)
        board.clear_cell(move)
        return true
      else
        board.clear_cell(move)
        return false
      end
    end
  end
end
