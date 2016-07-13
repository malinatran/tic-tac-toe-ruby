require_relative "constants"

module TicTacToe 
  class UserInterfaceHelper

    FORMAT = 
      { border:   "|",
        line:     "\n",
        prompt:   "> " }

    attr_accessor :input, :output

    def initialize(input = STDIN, output = STDOUT)
      @input = input
      @output = output
    end

    def get_string
      print_prompt
      @input.gets.chomp
    end

    def get_integer
      print_prompt
      @input.gets.chomp.to_i
    end

    def display(*messages)
      messages.each do |message|
        @output.print message
      end

      print_line
    end

    def display_board(board, size)
      display(FORMAT[:line], draw_board(board, size))
    end

    private

    def print_line
      @output.print FORMAT[:line]
    end

    def print_prompt
      @output.print FORMAT[:prompt]
    end

    def draw_board(board, size)
      mapped_board = ""

      board.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          cell_num = convert_to_cell_num(i, j, size)
          mapped_board << center_align(cell || cell_num.to_s)
          mapped_board << FORMAT[:border] if middle_cell?(j, size) 
          mapped_board << FORMAT[:line] if last_cell?(j, size) 
        end
      end

      mapped_board
    end

    def convert_to_cell_num(i, j, size)
      (i * size) + j + 1
    end

    def center_align(string)
      string.to_s.center(3) 
    end

    def middle_cell?(j, size)
      j < size - 1
    end

    def last_cell?(j, size)
      (j + 1) % size == 0
    end
  end
end
