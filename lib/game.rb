require_relative "board"
require_relative "computer_player"
require_relative "human_player"
require_relative "user_interface"

module TicTacToe
  class Game

    def initialize(params = {})
      @board = params[:board]
      @computer_player = params[:computer_player]    || ComputerPlayer.new
      @human_player = params[:human_player]          || HumanPlayer.new
      @user_interface = params[:user_interface] 
      @players = [@computer_player, @human_player]
      @current_player = @players.sample
    end

    def start_game
      while options = @user_interface.get_options
        @size = options[:size]
        @marker = options[:marker]
        set_options
        run_game_loop
      end
    end

    def set_options
      @board.size = @size
      @human_player.marker = @marker
    end

    def run_game_loop
      until is_game_over?
        if @current_player == @human_player
          @user_interface.display_board(@board.grid)
          move = @user_interface.select_move
          begin
            make_human_move(move)
          rescue Exception => message
            @user_interface.display_error(message)
          end
        elsif @current_player == @computer_player
          if is_computer_the_first_player? 
            make_first_move
          else
            make_computer_move
          end
        end
      end

      @user_interface.display_board(@board.grid)
      outcome = declare_outcome 
      @user_interface.display_outcome(outcome)
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
          return DRAW
        elsif win?
          declare_winner
        end
      end
    end

    private

    def is_computer_the_first_player?
      total_cells = @board.size * @board.size
      @board.get_empty_cells.length == total_cells && @board.retrieve_cells(@computer_player.marker).length == 0
    end

    def make_first_move
      move = get_center_or_first_cell

      @board.set_cell(move, @computer_player.marker)
      switch_player
    end

    def get_center_or_first_cell
      if @board.size % 2 == 0
        return {x: 0, y: 0}
      else
        center = @board.size / 2
        return {x: center, y: center} 
      end
    end

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
      score = @computer_player.minimax(@board, DEPTH, @current_player.marker, @human_player.marker)

      @computer_player.selected_move
    end
    
    def declare_winner
      if @winner == @computer_player
        return COMPUTER
      elsif @winner == @human_player
        return HUMAN 
      end
    end
  end
end
