require_relative = "board"
require_relative "computer_player"
require_relative "human_player"
require_relative "user_interface"

module TicTacToe

  class Game
    attr_reader :board, :computer_player, :human_player, :players, :current_player

    def initialize(params = {})
      @board = params[:board]
      @computer_player = params[:computer_player]    || ComputerPlayer.new
      @human_player = params[:human_player]          || HumanPlayer.new
      @players = [@computer_player, @human_player]
      @current_player = @players.sample
      @user_interface = params[:user_interface]      || UserInterface.new
    end

    def run_game_loop
      until is_game_over?
        if @current_player == @human_player
          @user_interface.display_board(@board.grid)
          move = @user_interface.select_move
          begin
            make_human_move(move)
          rescue Exception => message
            @user_interface.helper.display(message)
          end
        else
          make_computer_move
        end
      end
    end

    def make_computer_move
      move = request_computer_move
      @board.set_cell(move, @computer_player.marker)
      switch_player
    end

    def make_human_move(move)
      @board.set_cell(move, @human_player.marker)
      switch_player
    end

    def is_game_over?
      win? || draw?
    end

    def get_winner(player)
      if @board.is_either_diagonal_filled?(player.marker)
        @winner = player
        return @winner
      end

      @board.size.times do |n| 
        if @board.is_row_filled?(n, player.marker) || @board.is_column_filled?(n, player.marker)
          @winner = player
          return @winner
        end
      end

      nil
    end

    def declare_outcome
      if is_game_over?
        if draw?
          return "draw"
        elsif win?
          declare_winner
        end
      end
    end

    private

    def switch_player
      @current_player = (@current_player == @computer_player) ?
        @human_player :
        @computer_player
    end

    def win?
      @players.each do |player|
        if !get_winner(player).nil?
          return true
        end
      end
      false
    end

    def draw?
      @board.is_grid_filled? && win? == false
    end

    def is_computer_the_current_player?
      @current_player == @computer_player
    end

    def request_computer_move
      @computer_player.request_move(@board, @human_player.marker)
    end
    
    def declare_winner
      if @winner == @computer_player
        return "computer"
      elsif @winner == @human_player
        return "you"
      end
    end
  end
end
