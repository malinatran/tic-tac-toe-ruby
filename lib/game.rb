module TicTacToe

  class Game
    attr_reader :board, :computer_player, :human_player, :players, :current_player

    def initialize(params = {})
      @board = params[:board]
      @computer_player = params[:computer_player]    || TicTacToe::ComputerPlayer.new
      @human_player = params[:human_player]          || TicTacToe::HumanPlayer.new
      @user_interface = params[:user_interface]
      @players = [@computer_player, @human_player]
    end

    def switch_player
      @current_player == @computer_player ? @current_player = @human_player :
                                            @current_player = @computer_player
    end

    def is_game_over?
      win? || draw?
    end
   
    def get_winner(player)
      if @board.is_either_diagonal_filled?(player.marker)
        return player.marker
      end

      @board.size.times do |n| 
        if @board.is_row_filled?(n, player.marker) || @board.is_column_filled?(n, player.marker)
          return player.marker
        end
      end

      nil
    end

    def play_game_loop
      while !is_game_over?
        play_game
      end
    end

    def request_move
      @user_interface.display_board(@board)
      if @current_player == @computer_player
        @computer_player.request_move(@board, @human_player.marker)
      end
    end
  
    def return_human_move
      @user_interface.request_move(@board.size)
    end

    private

    def win?
      @players.each do |player|
        if get_winner(player) == player.marker
          return true
        end
      end
      false
    end

    def draw?
      @board.is_grid_filled? && win? == false
    end

    def select_player
      @current_player = @players.sample
    end

    def play_game
      switch_player
      request_move
    end
  end
end
