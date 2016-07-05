require_relative "helper"

module TicTacToe 
  class UserInterface 

    def initialize(helper)
      @helper = helper
      @size = 3
      @marker = "O"
    end

    def menu
      "Enter 1, 2, 3, or 4 to continue:
      (1) Change board size
      (2) Change marker
      (3) Proceed to game with a #{@size}x#{@size} board and #{@marker} as your marker
      (4) Exit"
    end

    def get_options
      @helper.display(DEFAULT_MESSAGES[:welcome])

      begin
        @helper.display(NEW_LINE, menu, NEW_LINE)
        menu_option = @helper.get_input
        case menu_option
        when OPTIONS[:one] 
          select_size 
        when OPTIONS[:two] 
          select_marker 
        when OPTIONS[:three] 
          return { size: @size, marker: @marker }
        when OPTIONS[:four]
          @helper.display(DEFAULT_MESSAGES[:goodbye], NEW_LINE)
          @quit_game = true
        end
      end until @quit_game
    end

    def display_error(message)
      @helper.display(NEW_LINE, message, NEW_LINE)
    end

    def select_size
      begin 
        @helper.display(DEFAULT_MESSAGES[:size], NEW_LINE)
        size = @helper.get_input.to_i
      end until @helper.is_size_valid?(size)

      @size = size
    end

    def select_marker
      begin
        @helper.display(DEFAULT_MESSAGES[:marker], NEW_LINE)
        marker = @helper.get_input
      end until @helper.is_marker_valid?(marker)

      @marker = marker
    end

    def select_move
      begin
        @helper.display(DEFAULT_MESSAGES[:move], NEW_LINE)
        move = @helper.get_input.to_i
      end until @helper.is_move_valid?(move, @size) 

      @helper.map_move(move, @size)
    end

    def display_board(board)
      @helper.display(NEW_LINE, @helper.draw_board(board, @size), NEW_LINE)
    end

    def display_outcome(outcome)
      if outcome == DRAW
        @helper.display(DEFAULT_MESSAGES[:draw], NEW_LINE)
      elsif outcome == COMPUTER
        @helper.display(DEFAULT_MESSAGES[:computer], NEW_LINE)
      elsif outcome == HUMAN 
        @helper.display(DEFAULT_MESSAGES[:human], NEW_LINE)
      end

      @helper.display(NEW_LINE)
    end
  end
end
