require "./game"

module TicTacToe

  class Play
    attr_reader :game
    attr_accessor :board_size, :marker

    def initialize
      @game = Game.new
      @board_size = 3
      @marker = MARKERS[1]
    end

    def start_game
      @game.select_random_player
      puts "Here's the board:"
    end

    def play_game
      while !@game.winner
        self.draw_board
        print "\n"
        self.request_moves
        @game.switch_player
      end

      self.draw_board
      print "\n"
      self.declare_winner
    end

    def display_menu_options
      puts "Welcome to tic-tac-toe!"
      main_options = "Enter 1, 2, 3, or 4 to continue:
      (1) Change board size
      (2) Change marker
      (3) Proceed to game with a #{@board_size}x#{@board_size} board and #{@marker} as your marker
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
          self.start_game
          break
        when "4"
          puts "Adios!"
          exit
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
          @board_size = response
          puts "Your board size is: #{@board_size}x#{@board_size}.\n\n"
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
          @marker = response 
          puts "Your marker is: #{@marker}.\n\n"
          self.display_menu_options
          break
        else 
          puts marker_option
          print PROMPT
          response = gets.chomp.upcase
        end
      end
    end

    def draw_board
      @game.board.grid.each_with_index do |x, row|
        x.each_with_index do |y, col|
          print y || (row * @board_size + col + 1)
          print " | " if @board_size - col > 1
        end
        print "\n"
      end
    end

    def request_moves
      if @game.current_player == @game.computer_player
        puts "Computer made a move:"
        computer_move = @game.computer_player.request_move(board: @game.board, 
                                                           size: @board_size, 
                                                           opponent_marker: @marker)
        @game.set_cell(computer_move, MARKERS[0])
      else
        puts "Enter your move:"
        print PROMPT
        cell_number = gets.chomp.to_i - 1
        row = (cell_number / @board_size)
        col = (cell_number % @board_size)
        player_move = {x: row, y: col}
        @game.set_cell(player_move, @marker)
      end
    end

    def declare_winner
      if @game.winner == "tie"
        puts "It was a tie!"
      elsif @game.winner == MARKERS[0]
        puts "Computer wins!"
      else
        puts "Human wins!"
      end
    end
  end
end

play = TicTacToe::Play.new
play.display_menu_options
play.play_game
