require_relative "board"
require_relative "game"
require_relative "human_player"

module TicTacToe 
  class UserInterface 
    attr_accessor :input, :output

    NEW_LINE = "\n"
    PROMPT = "> "

    def initialize(input = STDIN, output = STDOUT)
      @input = input 
      @output = output
      @size = 3
      @marker = "O"
    end

    def run_menu_loop
      display(default_messages[:welcome])

      begin
        display(NEW_LINE, default_messages[:menu], NEW_LINE)
        menu_option = get_input
        perform_menu_action(menu_option)
      end until @quit_game
    end

    def initialize_game
      board = Board.new(@size)
      human_player = HumanPlayer.new(@marker)
      @game = Game.new(board: board, human_player: human_player)
    end

    def run_game_loop
      until @game.is_game_over?
        if @game.current_player == @game.human_player
          display_board
          move = select_move
          @game.make_human_move(move)
        else
          @game.make_computer_move
        end
      end

      display_board
      display_outcome
    end

    def perform_menu_action(menu_option) 
      case menu_option
      when "1"
        select_size 
      when "2"
        select_marker 
      when "3"
        initialize_game
        run_game_loop
      when "4"
        puts "Adios!"
        @quit_game = true
      end
    end

    def select_size
      begin 
        display(default_messages[:size], NEW_LINE)
        size = get_input.to_i
      end until is_size_valid?(size)

      @size = size
    end

    def select_marker
      begin
        display(default_messages[:marker], NEW_LINE)
        marker = get_input
      end until is_marker_valid?(marker)

      @marker = marker
    end

    def display_board
      display(NEW_LINE, draw_board, NEW_LINE)
    end

    def select_move
      begin
        display(default_messages[:move], NEW_LINE)
        move = get_input.to_i
      end until is_move_valid?(move) 

      move
    end

    def display_outcome
      outcome = @game.declare_outcome

      if outcome == "draw"
        display(default_messages[:draw], NEW_LINE)
      elsif outcome == "computer"
        display(default_messages[:computer], NEW_LINE)
      else 
        display(default_messages[:human], NEW_LINE)
      end
    end

    private

    def get_input
      display(PROMPT)
      @input.gets.chomp
    end

    def display(*messages)
      messages.each do |message|
        output.print message
      end
    end

    # Should I make this a constant?
    def default_messages
      { welcome:  "Welcome to tic-tac-toe!",
        menu:     "Enter 1, 2, 3, or 4 to continue:
        (1) Change board size
        (2) Change marker
        (3) Proceed to game with with a #{@size}x#{@size} board and #{@marker} as your marker
        (4) Exit",
        size:     "Enter a board size:",
        marker:   "Enter a marker:",
        move:     "Enter your move:",
        draw:     "Nobody won!",
        computer: "Computer won!",
        human:    "You (somehow) won!" }
    end

    def is_size_valid?(size)
      size <= 9 && size > 1
    end

    def is_marker_valid?(marker)
      marker != "X" && marker.length == 1 ? true : false
    end

    def is_move_valid?(move)
      cell_nums = @size * @size
      move <= cell_nums && move > 0 ? true : false
    end

    def draw_board
      board = ""

      @game.board.grid.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          cell_num = (i * @size) + j + 1
          board << (cell || cell_num.to_s)
          board << " | " if j < @size - 1
          board << "\n" if (j + 1) % @size == 0
        end
      end

      board
    end
  end
end
