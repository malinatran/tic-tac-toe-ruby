module TicTacToe 
  class UserInterface 
    attr_accessor :input, :output

    NEW_LINE = "\n"
    PROMPT = "> "

    def initialize(input = STDIN, output = STDOUT)
      @input = input 
      @output = output
    end

    def display_menu(size, marker)
      @menu_option = "Enter 1, 2, 3, or 4 to continue:
      (1) Change board size
      (2) Change marker
      (3) Proceed to game with with a #{size}x#{size} board and #{marker} as your marker
      (4) Exit"
      display(default_messages[:welcome], NEW_LINE, @menu_option, NEW_LINE, PROMPT)
      select_menu
    end

    def select_menu
      choice = get_input 

      while choice do 
        case choice
        when "1"
          display_size_options
          break
        when "2"
          display_marker_options
          break
        when "3"
          start_game = true 
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
      false
    end

    def display_size_options
      display(default_messages[:size], NEW_LINE, PROMPT)
      select_size
    end

    def select_size
      size = get_input

      if !is_size_valid?(size)
        display_size_options
      else
        display("Your board is: #{size}x#{size}.")
        return size.to_i
      end
    end

    def display_marker_options
      display(default_messages[:marker], NEW_LINE, PROMPT)
      select_marker
    end

    def select_marker
      marker = get_input

      if !is_marker_valid?(marker)
        display_marker_options
      else
        display("Your marker is: #{marker}.")
        return marker
      end
    end

    def display_board(board)
      display(default_messages[:board], NEW_LINE, draw_board(board))
    end

    def display_move_request(size)
      display(default_messages[:move], NEW_LINE, PROMPT)
      select_move(size)
    end

    def select_move(size)
      move = get_input

      if !is_move_valid?(move, size)
        display_move_request(size)
      else
        return move.to_i
      end
    end

    def declare_draw
      display(default_messages[:draw])
    end

    def declare_winner(winner)
      display("And the winner is... #{winner}!")
    end
  
    private

    def get_input
      @input.gets
    end

    def display(*messages)
      messages.each do |message|
        output.print message
      end
    end

    def default_messages
      { welcome:  "Welcome to tic-tac-toe!",
        size:     "Enter a board size:",
        marker:   "Enter a marker:",
        board:    "The board:",
        move:     "Enter your move:",
        draw:     "Nobody wins!" }
    end

    def is_size_valid?(size)
      size = size.to_i
      size <= 9 && size > 1 ? true : false 
    end

    def is_marker_valid?(marker)
      marker != "X" && marker.length == 1 ? true : false
    end

    def is_move_valid?(move, size)
      move = move.to_i
      cell_nums = size * size
      move <= cell_nums && move > 0 ? true : false
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
