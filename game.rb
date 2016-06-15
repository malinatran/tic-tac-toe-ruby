require "./board"
require "./computer_player"
require "./human_player"

module TicTacToe

  class Game
    attr_reader :board, :computer_player, :human_player, :mapped_grid, :current_player

    def initialize(params = {})
      @board = params[:board]                      || TicTacToe::Board.new
      @computer_player = params[:computer_player]  || TicTacToe::ComputerPlayer.new
      @human_player = params[:human_player]        || TicTacToe::HumanPlayer.new
      @mapped_grid = create_grid_mapping(board.size)
    end

    def select_random_player
      @current_player = [computer_player, human_player].sample
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
      mapped_grid = {}
      size.times do |x|
        size.times do |y|
          mapped_grid[i] = [x, y] 
          i += 1
        end
      end
      mapped_grid
    end

    def format_grid 
      formatted_grid = ""
      mapped_grid.each do |k, v|
        if k == 1
          formatted_grid << "\n#{k}"
        elsif k % board.size == 0
          formatted_grid << "#{k}\n"
        else
          formatted_grid << "#{k}"
        end
      end
      return formatted_grid
    end

    def draw_grid(formatted_grid)
      print formatted_grid.split("").join(" | ")
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
