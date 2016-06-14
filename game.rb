require "./board"
require "./computer_player"
require "./human_player"

module TicTacToe

  class Game
    attr_reader :board, :computer_player, :human_player, :map, :board_size_option, :marker_option

    def initialize(params = {})
      @board = params[:board]                      || TicTacToe::Board.new
      @computer_player = params[:computer_player]  || TicTacToe::ComputerPlayer.new
      @human_player = params[:human_player]        || TicTacToe::HumanPlayer.new
      @map = create_grid_mapping(board.size)
    end

    def current_player
      computer_player
    end

    def switch_player
      if current_player == computer_player
        current_player = human_player
      else
        current_player = computer_player
      end
    end

    def create_grid_mapping(size)
      i = 1
      map = {}
      size.times do |x|
        size.times do |y|
          map[i] = [x, y] 
          i += 1
        end
      end
      map
    end

    def pick_cell(x, y, marker)
      begin
        board.set_cell(x, y, marker)
      rescue
        print(marker)
      ensure
      end
    end
  end
end
