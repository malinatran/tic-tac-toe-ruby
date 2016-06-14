require "./board"
require "./computer_player"
require "./human_player"

module TicTacToe

  class Game
    attr_reader :board, :computer_player, :human_player, :mapped_grid, :board_size_selection, :marker_selection

    def initialize(params = {})
      @board = params[:board]                      || TicTacToe::Board.new
      @computer_player = params[:computer_player]  || TicTacToe::ComputerPlayer.new
      @human_player = params[:human_player]        || TicTacToe::HumanPlayer.new
      @mapped_grid = create_grid_mapping(board.size)
    end

    def solicit_board_size
      prompt = "> "
      puts "Welcome to tic-tac-toe!\nDo you want to enter a custom board size? (Y or N)\n"
      print prompt

      while response = gets.chomp  
        case response
        when "Y"
          self.select_board_size
          break
        when "N"
          puts "Your board size is 3x3."
          break
        else
          puts "Please enter Y or N."
          print prompt
        end
      end
    end

    def select_board_size
      prompt = "> "
      puts "Please enter your board size:"
      print prompt
      @board_size_selection = gets.chomp.to_i
      puts "Your board size is: #{board_size_selection}x#{board_size_selection}."
    end

    def solicit_marker
      prompt = "> "
      puts "Do you want to enter your own marker? (Y or N)\n"
      print prompt

      while response = gets.chomp
        case response
        when "Y" 
          self.select_marker
          break
        when "N"
          puts "Your marker is 'O'."
          break
        else
          puts "Please enter Y or N."
          print prompt
        end
      end
    end

    def select_marker
      prompt = "> "
      puts "Please enter your marker:"
      print prompt
      @marker_selection = gets.chomp.to_s
      puts "Your marker is: #{marker_selection}."
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

 # game = TicTacToe::Game.new
 # game.solicit_board_size
 # game.solicit_marker
 # game.format_grid
