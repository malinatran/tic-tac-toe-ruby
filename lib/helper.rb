module TicTacToe 
  class Helper
    attr_accessor :input, :output

    NEW_LINE = "\n"
    PROMPT = "> "
    DEFAULT_MESSAGES = 
      { welcome:  "Welcome to tic-tac-toe!",
        goodbye:  "Adios!",
        size:     "Enter a board size (between 3 and 10):",
        marker:   "Enter a marker (single character that is not 'X'):",
        move:     "Enter your move:",
        draw:     "Nobody won!",
        computer: "Computer won!",
        human:    "You (somehow) won!" }
    
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
  end
end
