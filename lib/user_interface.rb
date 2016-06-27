require_relative "board"
require_relative "game"
require_relative "human_player"
require_relative "helper"

module TicTacToe 
  class UserInterface 

    def initialize
      @size = 3
      @marker = "O"
      @helper = Helper.new
    end

    def initialize_game
      board = Board.new(@size)
      human_player = HumanPlayer.new(@marker)
      @game = Game.new(board: board, human_player: human_player)
    end

    def menu
      "Enter 1, 2, 3, or 4 to continue:
      (1) Change board size
      (2) Change marker
      (3) Proceed to game with a #{@size}x#{@size} board and #{@marker} as your marker
      (4) Exit"
    end

    def run_menu_loop
      @helper.display(Helper::DEFAULT_MESSAGES[:welcome])

      begin
        @helper.display(Helper::NEW_LINE, menu, Helper::NEW_LINE)
        menu_option = @helper.get_input
        perform_menu_action(menu_option)
      end until @quit_game
    end

    def run_game_loop
      until @game.is_game_over?
        if @game.current_player == @game.human_player
          display_board
          move = select_move
          begin 
            @game.make_human_move(move)
          rescue Exception => message
            @helper.display(Helper::NEW_LINE, message, Helper::NEW_LINE)
          end
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
        @helper.display(Helper::DEFAULT_MESSAGES[:goodbye], Helper::NEW_LINE)
        @quit_game = true
      end
    end

    def select_size
      begin 
        @helper.display(Helper::DEFAULT_MESSAGES[:size], Helper::NEW_LINE)
        size = @helper.get_input.to_i
      end until @helper.is_size_valid?(size)

      @size = size
    end

    def select_marker
      begin
        @helper.display(Helper::DEFAULT_MESSAGES[:marker], Helper::NEW_LINE)
        marker = @helper.get_input
      end until @helper.is_marker_valid?(marker)

      @marker = marker
    end

    def draw_board
      board = ""

      @game.board.grid.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          cell_num = (i * @size) + j + 1
          board << (cell || cell_num.to_s).to_s.center(3)
          board << "|" if j < @size - 1
          board << "\n" if (j + 1) % @size == 0
        end
      end

      board
    end

    def display_board
      @helper.display(Helper::NEW_LINE, draw_board, Helper::NEW_LINE)
    end

    def select_move
      begin
        @helper.display(Helper::DEFAULT_MESSAGES[:move], Helper::NEW_LINE)
        move = @helper.get_input.to_i
      end until @helper.is_move_valid?(move, @size) 

      @helper.map_move(move, @size)
    end

    def display_outcome
      outcome = @game.declare_outcome

      if outcome == "draw"
        @helper.display(Helper::DEFAULT_MESSAGES[:draw], Helper::NEW_LINE)
      elsif outcome == "computer"
        @helper.display(Helper::DEFAULT_MESSAGES[:computer], Helper::NEW_LINE)
      else 
        @helper.display(Helper::DEFAULT_MESSAGES[:human], Helper::NEW_LINE)
      end
    end
  end
end
