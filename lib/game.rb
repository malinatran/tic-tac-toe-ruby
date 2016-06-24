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

    def start_game
      if @user_interface.start_game == true
        select_player
        play_game_loop
      end
    end

    def select_player
      @current_player = @players.sample
    end

    def switch_player
      @current_player == @computer_player ? @current_player = @human_player :
        @current_player = @computer_player
    end

    def retrieve_size
      size = @user_interface.select_size
      @board = TicTacToe::Board.new(size) 
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

    def play_game_loop
      while !is_game_over?
        play_game
      end
    end

    def request_move
      if is_computer_the_current_player? 
        computer_move = request_computer_move
        @board.set_cell(computer_move, @computer_player.marker)
      else
        human_move = map_move(request_human_move)
        @board.set_cell(human_move, @human_player.marker)
      end
    end

    def request_computer_move
      @computer_player.request_move(@board, @human_player.marker)
    end

    def request_human_move
      @user_interface.display_move_request(@board.size)
    end

    def map_move(move)
      move -= 1
      x = move / @board.size
      y = move % @board.size
      {x: x, y: y}
    end

    def declare_outcome
      if is_game_over?
        if draw?
          @user_interface.declare_draw
        elsif win?
          @user_interface.declare_winner(@winner)
        end
      end
    end

    def declare_winner
      if @winner == @computer_player
        return "computer"
      elsif @winner == @human_player
        return "you"
      end
    end

    private

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

    def play_game
      @user_interface.display_board(@board)
      request_move
      switch_player
    end

    def is_computer_the_current_player?
      @current_player == @computer_player
    end
  end
end
