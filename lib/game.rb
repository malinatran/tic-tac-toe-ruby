require_relative "board"
require_relative "computer_player"
require_relative "constants"
require_relative "game_state"
require_relative "human_player"
require_relative "user_interface"

module TicTacToe
  class Game

    DEPTH = 0

    def initialize(params = {})
      @board =            params[:board]
      @computer_player =  params[:computer_player] || ComputerPlayer.new
      @human_player =     params[:human_player]    || HumanPlayer.new
      @user_interface =   params[:user_interface] 
      @players =          [@computer_player, @human_player]
      @current_player =   @players.sample
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
      markers = get_markers

      until TicTacToe::GameState::is_game_over?(@board, markers)
        move = @current_player.make_move(board:          @board,
                                         user_interface: @user_interface,
                                         current_marker: @current_player.marker,
                                         human_marker:   @human_player.marker)
        set_move(move, @current_player.marker) 
      end

      determine_outcome(markers)
    end

    private

    def get_markers
      markers = []

      @players.each do |player|
        markers << player.marker
      end

      markers
    end

    def set_move(move, marker)
      begin
        @board.set_cell(move, marker)
        switch_player
      rescue Exception => message
        @user_interface.display_error(message)
      end
    end

    def switch_player
      @current_player = (@current_player == @computer_player) ?
        @human_player :
        @computer_player
    end

    def determine_outcome(markers)
      @user_interface.display_board(@board.grid)
      outcome = TicTacToe::GameState::determine_outcome(@board, markers)
      @user_interface.display_outcome(outcome)
    end
  end
end
