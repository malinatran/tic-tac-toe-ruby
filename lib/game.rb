module TicTacToe

  class Game
    attr_reader :board, :computer_player, :human_player, :players, :current_player

    def initialize(params = {})
      @board = params[:board]
      @computer_player = params[:computer_player]    || TicTacToe::ComputerPlayer.new
      @human_player = params[:human_player]          || TicTacToe::HumanPlayer.new
      @players = [@computer_player, @human_player]
    end

    def select_player
      @current_player = @players.sample
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

    def play_game
      switch_player
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
  end
end
