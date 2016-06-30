require "pry"
require_relative "player"
require_relative "board"

module TicTacToe
  class ComputerPlayer < Player

    attr_reader :marker, :move

    def default_marker
      MARKERS[0]
    end

    def minimax(board, player_marker, opponent_marker)
      return score(board, player_marker, opponent_marker) if is_game_over?(board, opponent_marker)

      scores = {}
      moves = board.get_empty_cells

      moves.each do |move|
        board_copy = board.dup
        board_copy.set_cell(move, opponent_marker)
        scores[move] = minimax(board_copy, switch(player_marker), switch(opponent_marker))
        end
      end

      @move, score = best_move(player_marker, scores)
      score
    end

    def score(board, player_marker, opponent_marker)
      if get_winner(board, player_marker) == "X"
        10
      elsif get_winner(board, player_marker) == opponent_marker
        -10
      else
        0
      end
    end

    def switch(player_marker)
      player_marker == "X" ? "O" : "X"
    end

    def best_move(player_marker, scores)
      if player_marker == "X"
        scores.max_by {|k, v| v}
      else
        scores.min_by {|k, v| v}
      end
    end

    def is_game_over?(board, opponent_marker)
      draw?(board, opponent_marker) || win?(board, opponent_marker)
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
          scores[move] = 10
        elsif is_winning_move?(board, move, opponent_marker)
          scores[move] = -10
        else
          scores[move] = 0
        end
      end

      scores
    end

    def select_optimal_move(scores)
      scores.key(10) || scores.key(-10) || scores.key(0)
    end

    def is_winning_move?(board, move, marker)
      x = move[:x]
      y = move[:y]
      board.set_cell(move, marker)

      if board.is_row_filled?(x, marker) || board.is_column_filled?(y, marker) ||
         board.is_either_diagonal_filled?(marker)
        board.clear_cell(move)
        return true
      else
        board.clear_cell(move)
        return false
      end
    end

    def is_winning_move?(board, move, marker)
      x = move[:x]
      y = move[:y]
      board.set_cell(move, marker)

      if board.is_row_filled?(x, marker) || board.is_column_filled?(y, marker) ||
        board.is_either_diagonal_filled?(marker)
        board.clear_cell(move)
        return true
      else
        board.clear_cell(move)
        return false
      end
    end

    private

    def draw?(board, opponent_marker)
      board.is_grid_filled? && win?(board, opponent_marker) == false
    end

    def win?(board, opponent_marker)
      player_markers = [marker, opponent_marker]

      player_markers.each do |player_marker|
        if !get_winner(board, player_marker).nil?
          return true
        end
      end

      false
    end

    def get_winner(board, player_marker)
      if board.is_either_diagonal_filled?(player_marker)
        return player_marker
      end

      board.size.times do |n| 
        if board.is_row_filled?(n, player_marker) || board.is_column_filled?(n, player_marker)
          return player_marker 
        end
      end

      nil
    end
  end
end
