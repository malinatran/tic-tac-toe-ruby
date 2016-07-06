require_relative "constants"

module TicTacToe 
  class UserInterfaceHelper

    attr_accessor :input, :output

    def initialize(input = STDIN, output = STDOUT)
      @input = input
      @output = output
    end

    def get_input
      print FORMAT[:prompt]
      @input.gets.chomp
    end

    def display(*messages)
      print FORMAT[:line]

      messages.each do |message|
        output.print message
      end
      
      print FORMAT[:line]
    end

    def map_move(move, size) 
      move -= 1
      x = move / size
      y = move % size
      {x: x, y: y}
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
