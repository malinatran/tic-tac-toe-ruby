module TicTacToe 
  class UserInterface 
    attr_accessor :input, :output

    NEW_LINE = "\n"
    PROMPT = "> "

    def initialize(input = STDIN, output = STDOUT)
      @input = input 
      @output = output
    end

    def get_input
      @input.gets.chomp
    end

    def display_menu(size, marker)
      welcome_message = "Welcome to tic-tac-toe!"
      @menu_option = "Enter 1, 2, 3, or 4 to continue:
      (1) Change board size
      (2) Change marker
      (3) Proceed to game with with a #{size}x#{size} board and #{marker} as your marker
      (4) Exit"
      display(welcome_message, NEW_LINE, @menu_option, NEW_LINE, PROMPT)
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

    def start_game
      # this should direct to Game
    end

    def display_size_options
      display(size_message, NEW_LINE, PROMPT)
      select_size
    end

    def select_size
      size = get_input

      # while true do 
        get_valid_size(size)
      # end
    end

    def display_marker_options
      display(marker_message, NEW_LINE, PROMPT)
      select_marker
    end

    def select_marker
      marker = get_input

      # while true do
        get_valid_marker(marker)
      # end
    end

    def display_board(board)
      display(board_message, NEW_LINE, draw_board(board))
    end

    def request_move(size)
      display(move_message, NEW_LINE, PROMPT)
      select_move(size)
    end

    def select_move(size)
      move = gets.chomp

      # while true do
        get_valid_move(move, size)
      # end
    end

    private

    def display(*messages)
      messages.each do |message|
        output.print message
      end
    end

    def size_message
      "Enter a board size:"
    end
    
    def marker_message
      "Enter a marker:" 
    end

    def board_message
      "The board:"
    end

    def move_message
      "Enter your move:"
    end

    def get_valid_size(size)
      size = size.to_i

      if size <= 9 && size > 1
        display("Your board is: #{size}x#{size}.")
        return size
      else
        display(size_message, NEW_LINE, PROMPT)
      end
    end

    def get_valid_marker(marker)
      marker = marker.capitalize

      if marker.match(/[a-zA-Z]/) && marker != "X" && marker.length == 1
        display("Your marker is: #{marker}.")
        return marker
      else
        display(marker_message, NEW_LINE, PROMPT)
      end
    end
      
    def get_valid_move(move, size)
      move = move.to_i
      cell_nums = size * size

      if move <= cell_nums && move > 0
        return move
      else
        display(move_message, NEW_LINE, PROMPT)
      end
    end

    def draw_board(board)
      printed_board = ""
      
      board.grid.each_with_index do |row, i|
        row.each_with_index do |column, j|
          cell_num = (i * board.size) + j + 1
          printed_board += "#{cell_num}"
          printed_board += " | " if j < board.size - 1
          printed_board += "\n" if (j + 1) % board.size == 0
        end
      end

      printed_board
    end
  end
end
