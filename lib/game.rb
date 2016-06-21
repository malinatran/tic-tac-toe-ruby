module TicTacToe

  class Game
    attr_reader :board, :computer_player, :human_player, :current_player

    def initialize(params = {})
      @board = params[:board]                        || TicTacToe::Board.new
      @computer_player = params[:computer_player]    || TicTacToe::ComputerPlayer.new
      @human_player = params[:human_player]          || TicTacToe::HumanPlayer.new
    end

    def select_player
      players = [@computer_player, @human_player]
      @current_player = players.sample
    end

    def switch_player
      @current_player == @computer_player ? @current_player = @human_player :
                                            @current_player = @computer_player
    end
  end
end
