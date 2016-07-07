require_relative "constants"

module TicTacToe 
  class UserInterfaceHelper

    FORMAT = 
      { line:     "\n",
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
        output.print message
      end

      print_line
    end

    def display_outcome(outcome)
      if outcome == DRAW
        display(MESSAGE[:draw])
      elsif outcome == MARKER[:computer]
        display(MESSAGE[:computer])
      elsif outcome == MARKER[:human] 
        display(MESSAGE[:human])
      end

      print_line
    end

    def display_board(board, size)
      display(FORMAT[:line], draw_board(board, size))
    end

    private

    def print_line
      print FORMAT[:line]
    end

    def print_prompt
      print FORMAT[:prompt]
    end

    def draw_board(board, size)
      mapped_board = ""

      board.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          cell_num = (i * size) + j + 1
          mapped_board << (cell || cell_num.to_s).to_s.center(3)
          mapped_board << "|" if j < size - 1
          mapped_board << "\n" if (j + 1) % size == 0
        end
      end

      mapped_board
    end
  end
end
