require_relative "constants"
require_relative "input_validator"
require_relative "user_interface_helper"

module TicTacToe 
  class UserInterface 

    DRAW = "Draw"

    def initialize(ui_helper, validator)
      @ui_helper = ui_helper
      @validator = validator
      @size = 3
      @marker = MARKER[:human] 
    end

    def get_options
      @ui_helper.display(MESSAGE[:welcome])

      begin
        @ui_helper.display(menu)
        menu_option = @ui_helper.get_input.to_i

        case menu_option
        when 1 
          select_size 
        when 2 
          select_marker 
        when 3 
          return { size: @size, marker: @marker }
        when 4 
          @ui_helper.display(MESSAGE[:goodbye])
          @quit_game = true
        end
      end until @quit_game
    end

    def select_move
      begin
        @ui_helper.display(MESSAGE[:move])
        move = @ui_helper.get_input.to_i
      end until @validator.is_move_valid?(move, @size) 

      @ui_helper.map_move(move, @size)
    end

    def display_error(message)
      @ui_helper.display(message)
    end

    def display_board(board)
      @ui_helper.display(FORMAT[:line], @ui_helper.draw_board(board, @size))
    end

    def display_outcome(outcome)
      if outcome == DRAW
        @ui_helper.display(MESSAGE[:draw])
      elsif outcome == MARKER[:computer]
        @ui_helper.display(MESSAGE[:computer])
      elsif outcome == MARKER[:human] 
        @ui_helper.display(MESSAGE[:human])
      end
    end

    private

    def menu
      "Enter 1, 2, 3, or 4 to continue:
      (1) Change board size
      (2) Change marker
      (3) Proceed to game with a #{@size}x#{@size} board and #{@marker} as your marker
      (4) Exit"
    end

    def select_size
      begin 
        @ui_helper.display(MESSAGE[:size])
        size = @ui_helper.get_input.to_i
      end until @validator.is_size_valid?(size)

      @size = size
    end

    def select_marker
      begin
        @ui_helper.display(MESSAGE[:marker])
        marker = @ui_helper.get_input
      end until @validator.is_marker_valid?(marker)

      @marker = marker
    end
  end
end
