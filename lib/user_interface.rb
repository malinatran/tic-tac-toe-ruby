require_relative "user_interface_helper"
require_relative "input_validator"

module TicTacToe 
  class UserInterface 

    def initialize(ui_helper, validator)
      @ui_helper = ui_helper
      @validator = validator
      @size = 3
      @marker = MARKERS[1] 
    end

    def menu
      "Enter 1, 2, 3, or 4 to continue:
      (1) Change board size
      (2) Change marker
      (3) Proceed to game with a #{@size}x#{@size} board and #{@marker} as your marker
      (4) Exit"
    end

    def get_options
      @ui_helper.display(DEFAULT_MESSAGES[:welcome])

      begin
        @ui_helper.display(NEW_LINE, menu, NEW_LINE)
        menu_option = @ui_helper.get_input
        case menu_option
        when OPTIONS[:one] 
          select_size 
        when OPTIONS[:two] 
          select_marker 
        when OPTIONS[:three] 
          return { size: @size, marker: @marker }
        when OPTIONS[:four]
          @ui_helper.display(DEFAULT_MESSAGES[:goodbye], NEW_LINE)
          @quit_game = true
        end
      end until @quit_game
    end

    def display_error(message)
      @ui_helper.display(NEW_LINE, message, NEW_LINE)
    end

    def select_size
      begin 
        @ui_helper.display(DEFAULT_MESSAGES[:size], NEW_LINE)
        size = @ui_helper.get_input.to_i
      end until @validator.is_size_valid?(size)

      @size = size
    end

    def select_marker
      begin
        @ui_helper.display(DEFAULT_MESSAGES[:marker], NEW_LINE)
        marker = @ui_helper.get_input
      end until @validator.is_marker_valid?(marker)

      @marker = marker
    end

    def select_move
      begin
        @ui_helper.display(DEFAULT_MESSAGES[:move], NEW_LINE)
        move = @ui_helper.get_input.to_i
      end until @validator.is_move_valid?(move, @size) 

      @ui_helper.map_move(move, @size)
    end

    def display_board(board)
      @ui_helper.display(NEW_LINE, @ui_helper.draw_board(board, @size), NEW_LINE)
    end

    def display_outcome(outcome)
      if outcome == DRAW
        @ui_helper.display(DEFAULT_MESSAGES[:draw], NEW_LINE)
      elsif outcome == COMPUTER
        @ui_helper.display(DEFAULT_MESSAGES[:computer], NEW_LINE)
      elsif outcome == HUMAN 
        @ui_helper.display(DEFAULT_MESSAGES[:human], NEW_LINE)
      end

      @ui_helper.display(NEW_LINE)
    end
  end
end
