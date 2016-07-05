require_relative "board"
require_relative "computer_player"
require_relative "human_player"
require_relative "user_interface"
require_relative "game_state"
require_relative "constants"

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

    def generate_markers
      markers = []

      @players.each do |player|
        markers << player.marker
      end

      markers
    end

    def run_game_loop
      markers = generate_markers

      until TicTacToe::is_game_over?(@board, markers)
        if is_computer_the_current_player?
          make_computer_move
        else
          make_human_move  
        end
      end

      @user_interface.display_board(@board.grid)
      outcome = declare_outcome(@board, markers)
      @user_interface.display_outcome(outcome)
    end

    private

    def is_computer_the_current_player?
      @current_player == @computer_player
    end

    def make_human_move
      @user_interface.display_board(@board.grid)
      move = @user_interface.select_move
      begin
        set_human_move(move)
      rescue Exception => message
        @user_interface.display_error(message)
      end
    end

    def make_computer_move
      if is_computer_the_first_player? 
        make_first_move
      else
        make_minimax_move
      end
    end

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

    def make_minimax_move
      move = request_computer_move
      @board.set_cell(move, @computer_player.marker)
      switch_player
    end

    def request_computer_move
      @computer_player.minimax(@board, DEPTH, @current_player.marker, @human_player.marker)
      return @computer_player.move
    end

    def set_human_move(move)
      @board.set_cell(move, @human_player.marker)
      switch_player
    end

    def switch_player
      @current_player = (@current_player == @computer_player) ?
        @human_player :
        @computer_player
    end

    def declare_outcome(board, markers)
      if TicTacToe::is_game_over?(board, markers) 
        if TicTacToe::draw?(board, markers)
          return DRAW
        elsif TicTacToe::win?(board, markers)
          determine_winner
        end
      end
    end

    def determine_winner
      @players.each do |player|
        if TicTacToe::is_winner?(@board, player.marker)
          return player.marker
        end
      end
    end
  end
end
