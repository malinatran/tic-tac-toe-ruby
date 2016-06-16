require "./board"
require "./computer_player"
require "./human_player"

module TicTacToe

  PROMPT = "> "

  class Game
    attr_reader :board, :computer_player, :human_player, :mapped_grid, :current_player, :opponent_player

    def initialize(params = {})
      @board = params[:board]                      || TicTacToe::Board.new
      @computer_player = params[:computer_player]  || TicTacToe::ComputerPlayer.new
      @human_player = params[:human_player]        || TicTacToe::HumanPlayer.new
    end

    def select_random_player
      @current_player = [computer_player, human_player].sample
      puts @current_player
      not_current_player = [computer_player, human_player] - [current_player]
      @opponent_player = not_current_player[0]
      puts @opponent_player
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
      @mapped_grid = {}
      size.times do |x|
        size.times do |y|
          @mapped_grid[i] = [x, y] 
          i += 1
        end
      end
      @mapped_grid
    end

    def format_grid(size)
      formatted_grid = ""
      @mapped_grid.each do |k, v|
        if k == @mapped_grid.keys.last && k.to_s.length == 1
          formatted_grid << "0#{k}"
        elsif k == @mapped_grid.keys.last && k.to_s.length > 1
          formatted_grid << "#{k}"
        elsif k % size == 0 && k.to_s.length == 1
          formatted_grid << "0#{k}\n"
        elsif k % size == 0 && k.to_s.length > 1
          formatted_grid << "#{k}\n"
        elsif k.to_s.length == 1
          formatted_grid << "0#{k},"
        else
          formatted_grid << "#{k},"
        end
      end
      return formatted_grid
    end

    def is_game_over?
      if board.is_grid_filled?
        true
      else
        false
      end
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
