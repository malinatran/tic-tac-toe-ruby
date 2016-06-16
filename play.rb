require "./game"

module TicTacToe

  class Play
    attr_reader :game
    attr_accessor :board_size_selection, :marker_selection

    def initialize
      @game = Game.new
    end

    def start_game
      @game.select_random_player
      self.draw_grid
      
      while true do
        if @game.is_game_over? == false
          self.request_moves
          self.draw_grid
          @game.switch_player
        else
          self.declare_winner
          break
        end
      end
    end

    def display_menu_options
      puts "Welcome to tic-tac-toe!"
      main_options = "Enter 1, 2, 3, or 4 to continue:
      (1) Change board size
      (2) Change marker
      (3) Proceed to game with a #{@board_size_selection || 3}x#{@board_size_selection || 3} board and #{@marker_selection || MARKERS[1]} as your marker
      (4) Exit"
      puts main_options
      print PROMPT

      while response = gets.chomp
        case response
        when "1"
          self.select_board_size
          break
        when "2"
          self.select_marker
          break
        when "3" 
          break
        when "4"
          puts "Adios!"
          break
        end
      end
    end

    def select_board_size
      board_size_option = "Please enter a board size between 2 to 10:"
      puts board_size_option
      print PROMPT
      response = gets.chomp.to_i

      while true do
        if response <= 10 && response > 1
          @board_size_selection = response
          puts "Your board size is: #{@board_size_selection}x#{@board_size_selection}.\n\n"
          self.display_menu_options
          break
        else
          puts board_size_option
          print PROMPT
          response = gets.chomp.to_i
        end
      end
    end

    def select_marker
      marker_option = "Please enter a marker that is a single letter or digit that is not 'X':"
      puts marker_option
      print PROMPT
      response = gets.chomp.upcase

      while true do
        if response.length == 1 && response != "X" && response.match(/[a-zA-Z]/)
          @marker_selection = response 
          puts "Your marker is: #{@marker_selection}.\n\n"
          self.display_menu_options
          break
        else 
          puts marker_option
          print PROMPT
          response = gets.chomp.upcase
        end
      end
    end

    def draw_grid
      @game.create_grid_mapping(@board_size_selection || 3)
      print @game.format_grid(@board_size_selection || 3).split(",").join(" | ")
      print "\n\n"
    end

    def request_moves
      if @game.current_player == @game.computer_player
        computer_move = @game.computer_player.request_move(board: @game.board, size: @board_size_selection, marker: MARKERS[0])
        @game.set_cell(computer_move, MARKERS[0])
      else
        puts "Enter your move:"
        print PROMPT
        cell_number = gets.chomp.to_i
        coordinates = @game.mapped_grid[cell_number]
        player_move = {x: coordinates[0], y: coordinates[1]}
        @game.set_cell(player_move, @marker_selection || MARKERS[1])
      end
      puts @game.mapped_grid
    end

    def declare_winner
      puts "Winner announced here"
    end
  end
end

play = TicTacToe::Play.new
play.display_menu_options
play.start_game
