require_relative "game"

module TicTacToe

  class UserInterface
    attr_accessor :input, :output

    def initialize(input = STDIN, output = STDOUT, board)
      @input = input
      @output = output
      @board = board || TicTacToe::Board.new
      @marker = "O"
      @size = @board.size 
    end

    def get_input
      @input.gets.chomp
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
      welcome_message = "Welcome to tic-tac-toe!\n"
      menu_option = "Enter 1, 2, 3, or 4 to continue:
      (1) Change board size
      (2) Change marker
      (3) Proceed to game with with a #{@size}x#{@size} board and #{@marker} as your marker
      (4) Exit\n"
      display(welcome_message, menu_option, prompt)
      choice = get_input
    end

    def display_board
      @board.grid
    end
  end
end
