require "./game"

module TicTacToe

  class Play
    attr_reader :game
    attr_accessor :board_size_selection, :marker_selection

    def initialize
      @game = Game.new
    end

    def solicit_user_input
      self.display_options
    end


    def display_options
      puts "Welcome to tic-tac-toe!"
      main_options = "Enter 1, 2, 3, or 4 to continue:
      (1) Change board size
      (2) Change marker
      (3) Proceed to game with a #{@board_size_selection || 3}x#{@board_size_selection || 3} board and #{@marker_selection || 'O'} as your marker
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
          self.draw_grid
          self.request_moves
          break
        when "4"
          puts "Adios!"
          break
        else 
          puts main_options
          print PROMPT
        end
      end
    end

    def select_board_size
      board_size_option = "Please enter a board size between 2 to 10:"
      puts board_size_option
      print PROMPT
      response = gets.chomp.to_i

      while true do
        if response <= 10 
          @board_size_selection = response
          puts "Your board size is: #{@board_size_selection}x#{@board_size_selection}.\n\n"
          self.display_options
          break
        else
          puts board_size_selection
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
          self.display_options
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
      print "\n"
    end

    def request_moves
      @game.select_random_player
      if @game.current_player == @game.computer_player
        @game.computer_player.request_move(board: @game.board, size: @board_size_selection, marker: MARKERS[0])
      else
        puts "Enter your move:"
        print PROMPT
        move = gets.chomp
      end
    end
  end
end

play = TicTacToe::Play.new
play.solicit_user_input
