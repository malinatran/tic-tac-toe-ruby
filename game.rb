require "pry"
require "./board"
require "./computer_player"
require "./human_player"

module TicTacToe

  PROMPT = "> "

  class Game
    attr_reader :board, :computer_player, :human_player, :current_player, :opponent_player

    def initialize(params = {})
      @board = params[:board]                      || TicTacToe::Board.new
      @computer_player = params[:computer_player]  || TicTacToe::ComputerPlayer.new
      @human_player = params[:human_player]        || TicTacToe::HumanPlayer.new
    end

    def select_random_player
      @current_player = [computer_player, human_player].sample
      not_current_player = [computer_player, human_player] - [current_player]
      @opponent_player = not_current_player[0]
    end

    def switch_player
      if @current_player == computer_player
        @current_player = human_player
      else
        @current_player = computer_player
      end
    end

    def set_cell(move, marker)
      @board.set_cell(move, marker)
    end

    def winner
      if @board.is_either_diagonal_filled?(@current_player.marker)
        return @board.get_cell(@board.size / 2, @board.size / 2)
      end

      if @board.is_either_diagonal_filled?(@opponent_player.marker)
        return @board.get_cell(@board.size / 2, @board.size / 2)
      end

      @board.size.times do |n|
        if @board.is_row_filled?(n, @current_player.marker) || 
           @board.is_column_filled?(n, @current_player.marker)
          return @current_player.marker
        elsif @board.is_row_filled?(n, @opponent_player.marker) || 
              @board.is_column_filled?(n, @opponent_player.marker)
          return @opponent_player.marker
        end
      end

      return "tie" if @board.is_grid_filled?
      nil
    end
  end
end
