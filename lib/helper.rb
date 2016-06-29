module TicTacToe 
  
  NEW_LINE = "\n"
  PROMPT = "> "
  OPTIONS = 
    { one: "1",
      two: "2",
      three: "3",
      four: "4" }
  COMPUTER = "Computer"
  HUMAN = "Human"
  DRAW = "Draw"
  DEFAULT_MESSAGES = 
    { welcome:  "Welcome to tic-tac-toe!",
      goodbye:  "Adios!",
      size:     "Enter a board size (between 3 and 10):",
      marker:   "Enter a marker (single character that is not 'X'):",
      move:     "Enter your move:",
      draw:     "Nobody won!",
      computer: "Computer won!",
      human:    "You (somehow) won!" }

  class Helper
    attr_accessor :input, :output

    def initialize(input = STDIN, output = STDOUT)
      @input = input
      @output = output
    end

    def get_input
      display(PROMPT)
      @input.gets.chomp
    end

    def display(*messages)
      messages.each do |message|
        output.print message
      end
    end

    def is_size_valid?(size)
      size <= 10 && size > 2
    end

    def is_marker_valid?(marker)
      marker.capitalize != "X" && marker.length == 1 ? true : false
    end

    def is_move_valid?(move, size)
      cell_nums = size * size
      move <= cell_nums && move > 0 ? true : false
    end

    def map_move(move, size) 
      move -= 1
      x = move / size
      y = move % size
      {x: x, y: y}
    end

    def draw_board(board, size)
      mapped_board = ""

      board.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          cell_num = (i * size) + j + 1
          mapped_board << (cell || cell_num.to_s).to_s.center(3)
          mapped_board << "|" if j < size - 1
          mapped_board << "\n" if (j + 1) % size == 0
        end
      end

      mapped_board
    end
  end
end
