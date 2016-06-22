require_relative "game"

module TicTacToe

  class UserInterface
    attr_accessor :input, :output

    def initialize(params)
      @input = params[:input] || STDIN
      @output = params[:output] || STDOUT
      @board = params[:board]
      @marker = params[:human_player].marker
      @size = @board.size 
    end

    def get_input
      @input.gets.chomp
    end
  
    def line_break
      "\n"
    end

    def prompt
      "> "
    end

    def display(*messages)
      messages.each do |message|
        output.print message
      end
    end

    def display_menu
      welcome_message = "Welcome to tic-tac-toe!"
      @menu_option = "Enter 1, 2, 3, or 4 to continue:
      (1) Change board size
      (2) Change marker
      (3) Proceed to game with with a #{@size}x#{@size} board and #{@marker} as your marker
      (4) Exit"
      display(welcome_message, line_break, @menu_option, line_break, prompt)
      select_menu
    end
    
    def select_menu
      choice = get_input 
      
      while choice do 
        case choice
        when "1"
          select_size
          break
        when "2"
          select_marker
          break
        when "3"
          start_game
          break
        when "4"
          puts "Adios!"
          exit
        else
          display(@menu_option)
        end
      end
    end

    def display_size_options
      @size_message = "Enter a board size:"
      display(@size_message, line_break, prompt)
      select_size
    end

    def select_size
      size = get_input.to_i
    
      while true do
        if size.match(/[0-9]/)
          @size = size
          display("Your board is: #{@size}x#{@size}.")
          display_menu
          break
        else
          display(@size_message, line_break, prompt)
        end
      end
    end

    def display_marker_options
      @marker_message = "Enter a marker:"
      display(@marker_message, line_break, prompt)
      select_marker
    end

    def select_marker
      marker = get_input.capitalize

      while true do
        if marker.match(/[a-zA-Z]/) && marker != "X"
          @marker = marker[0]
          display("Your marker is: #{@marker}.")
          display_menu
          break
        else
          display(@marker_message, line_break, prompt)
        end
      end
    end

    def start_game
      # game.select_player
      # announce player
      # draw board
    end

    def draw_board
      printed_board = ""
      @board.grid.each_with_index do |row, i|
        row.each_with_index do |column, j|
          cell_num = (i * @size) + j + 1
          printed_board += "#{cell_num}"
          printed_board += " | " if j < @size - 1
          printed_board += "\n" if (j + 1) % @size == 0
        end
      end
      printed_board
    end
  end
end

