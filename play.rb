require "./game"

module TicTacToe

  class Play
    attr_reader :game, :current_player, :opponent_player, :board_size_selection, :marker_selection
    attr_accessor :formatted_grid

    def initialize
      @game = Game.new
      @formatted_grid = @game.format_grid
    end

    def solicit_user_input
      self.solicit_board_size
      self.solicit_marker
    end

    def start_game(game)
      self.draw_grid
      self.announce_current_player(game)
    end

    def solicit_board_size
      puts "Welcome to tic-tac-toe!\nDo you want to enter a custom board size? (Y or N)\n"
      print PROMPT

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
          print PROMPT
        end
      end
    end

    def select_board_size
      puts "Please enter your board size:"
      print PROMPT
      @board_size_selection = gets.chomp.to_i
      puts "Your board size is: #{board_size_selection}x#{board_size_selection}."
    end

    def solicit_marker
      puts "Do you want to enter your own marker? (Y or N)\n"
      print PROMPT

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
          print PROMPT
        end
      end
    end

    def select_marker
      puts "Please enter your marker:"
      print PROMPT
      @marker_selection = gets.chomp.to_s
      puts "Your marker is: #{marker_selection}."
    end

    def draw_grid
      print formatted_grid.split("").join(" | ")
      print "\n"
    end

    def announce_current_player(game)
      game.select_random_player
      puts "Opponent player: #{game.opponent_player}"
      puts "Current player: #{game.current_player}"
    end

    def request_moves
      if current_player = game.computer_player
        game.computer_player.request_move
      else
        puts "Enter the number of your move:"
        print PROMPT
        move = gets.chomp
      end
    end
  end
end

play = TicTacToe::Play.new
play.solicit_user_input
play.start_game(play.game)
