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
      @helper.display(Helper::DEFAULT_MESSAGES[:welcome])

      begin
        @helper.display(Helper::NEW_LINE, menu, Helper::NEW_LINE)
        menu_option = @helper.get_input
        case menu_option
        when "1"
          select_size 
        when "2"
          select_marker 
        when "3"
          return { size: @size, 
            marker: @marker }
        when "4"
          @helper.display(Helper::DEFAULT_MESSAGES[:goodbye], 
                          Helper::NEW_LINE)
          @quit_game = true
        end
      end until @quit_game
    end

    def display_error(message)
      @helper.display(Helper::NEW_LINE, message, Helper::NEW_LINE)
    end

    def select_size
      begin 
        @helper.display(Helper::DEFAULT_MESSAGES[:size], 
                        Helper::NEW_LINE)
        size = @helper.get_input.to_i
      end until @helper.is_size_valid?(size)

      @size = size
    end

    def select_marker
      begin
        @helper.display(Helper::DEFAULT_MESSAGES[:marker], 
                        Helper::NEW_LINE)
        marker = @helper.get_input
      end until @helper.is_marker_valid?(marker)

      @marker = marker
    end

    def select_move
      begin
        @helper.display(Helper::DEFAULT_MESSAGES[:move], 
                        Helper::NEW_LINE)
        move = @helper.get_input.to_i
      end until @helper.is_move_valid?(move, @size) 

      @helper.map_move(move, @size)
    end

    def display_board(board)
      @helper.display(Helper::NEW_LINE, 
                      @helper.draw_board(board, @size), 
                      Helper::NEW_LINE)
    end

    def display_outcome(outcome)
      if outcome == "draw"
        @helper.display(Helper::DEFAULT_MESSAGES[:draw], 
                        Helper::NEW_LINE)
      elsif outcome == "computer"
        @helper.display(Helper::DEFAULT_MESSAGES[:computer], 
                        Helper::NEW_LINE)
      else 
        @helper.display(Helper::DEFAULT_MESSAGES[:human], 
                        Helper::NEW_LINE)
      end
      @helper.display(Helper::NEW_LINE)
    end
  end
end
