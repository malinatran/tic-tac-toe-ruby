require_relative "board"
require_relative "constants"
require_relative "game_state"
require_relative "player"

module TicTacToe
  class ComputerPlayer < Player

    DEPTH = 0

    attr_reader :marker

    def default_marker
      MARKER[:computer] 
    end

    def make_move(params)
      @board =          params[:board]
      current_marker =  params[:current_marker]
      human_marker =    params[:human_marker]

      if is_computer_the_first_player?
        make_first_move
      else
        make_minimax_move(DEPTH, current_marker, human_marker)
      end
    end

    private

    def is_computer_the_first_player?
      total_cells = @board.size * @board.size
      @board.get_empty_cells.length == total_cells && @board.retrieve_cells(marker).length == 0
    end

    def make_first_move
      if @board.size % 2 == 0
        return {x: 0, y: 0}
      else
        center = @board.size / 2
        return {x: center, y: center} 
      end
    end

    def make_minimax_move(depth, current_marker, human_marker)
      minimax(@board, depth, current_marker, human_marker)
      return @move
    end

    def minimax(board, depth, current_marker, opponent_marker)
      markers = [current_marker, opponent_marker]

      if TicTacToe::GameState::is_game_over?(board, markers)
        return score(board, depth, opponent_marker)
      end

      depth += 1
      scores = {}

      board.get_empty_cells.each do |cell|
        board.set_cell(cell, current_marker)
        scores[cell] = minimax(board, depth, TicTacToe::GameState::switch(current_marker, opponent_marker), opponent_marker)
        board.clear_cell(cell)
      end

      @move, score = best_move(current_marker, scores)
      score
    end

    def score(board, depth, opponent_marker)
      if TicTacToe::GameState::is_winner?(board, marker)
        10 - depth
      elsif TicTacToe::GameState::is_winner?(board, opponent_marker)
        depth - 10
      else
        0
      end 
    end

    def best_move(current_marker, scores)
      if current_marker == MARKER[:computer]
        scores.max_by {|k, v| v}
      else
        scores.min_by {|k, v| v}
      end
    end
  end
end
