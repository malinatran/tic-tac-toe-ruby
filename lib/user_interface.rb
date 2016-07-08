require_relative "constants"
require_relative "input_validator"
require_relative "user_interface_helper"

module TicTacToe 
  class UserInterface 

    def initialize(ui_helper, validator)
      @ui_helper =    ui_helper
      @validator =    validator
      @size =         DEFAULT_SIZE 
      @marker =       MARKER[:human] 
    end

    def get_options
      display(MESSAGE[:welcome])

      begin
        display(menu)
        menu_option = @ui_helper.get_integer

        case menu_option
        when 1 
          select_size 
        when 2 
          select_marker 
        when 3 
          return { size: @size, marker: @marker }
        when 4 
          display(MESSAGE[:goodbye])
          @quit_game = true
        end
      end until @quit_game
    end

    def get_move(board)
      display_board(board)

      begin
        move = prompt_for_move
      end until @validator.is_move_valid?(move, @size) 

      @validator.translate_move(move, @size)
    end

    def display_error(error)
      display(error)
    end

    def display_board(board)
      @ui_helper.display_board(board, @size)
    end

    def display_outcome(outcome)
      @ui_helper.display_outcome(outcome)
    end

    private

    def display(message)
      @ui_helper.display(message)
    end

    def translate_move(move, size)
      @ui_helper.translate_move(move, size)
    end

    def menu
      "Enter 1, 2, 3, or 4 to continue:
      (1) Change board size
      (2) Change marker
      (3) Proceed to game with a #{@size}x#{@size} board and #{@marker} as your marker
      (4) Exit"
    end

    def select_size
      begin 
        size = prompt_for_size
      end until @validator.is_size_valid?(size)

      @size = size
    end

    def prompt_for_size
      display(MESSAGE[:size])
      @ui_helper.get_integer
    end

    def select_marker
      begin
        marker = prompt_for_marker
      end until @validator.is_marker_valid?(marker)

      @marker = marker
    end

    def prompt_for_marker
      display(MESSAGE[:marker])
      @ui_helper.get_string
    end

    def prompt_for_move
      display(MESSAGE[:move])
      @ui_helper.get_integer
    end
  end
end
