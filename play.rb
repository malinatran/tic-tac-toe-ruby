require "./game"

module TicTacToe
  
  class Play
    attr_reader :board_size_selection, :marker_selection

    def initialize
      @game = Game.new
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
  end
end

play = TicTacToe::Play.new
play.solicit_board_size
play.solicit_marker
