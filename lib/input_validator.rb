require_relative "constants"

module TicTacToe 
  class InputValidator

    def is_size_valid?(size)
      valid_size(size)
    end

    def is_marker_valid?(marker)
      valid_marker(marker)
    end

    def is_move_valid?(move, size)
      valid_move(move, size)
    end

    def translate_move(move, size)
      translation(move, size) 
    end

    private

    def valid_size(size)
      size <= 10 && size > 2
    end

    def valid_marker(marker)
      is_not_computer_marker?(marker) && 
      is_single_char?(marker) && 
      is_not_digit?(marker)
    end

    def is_not_computer_marker?(marker)
      marker.capitalize != MARKER[:computer]
    end

    def is_single_char?(marker)
      marker.length == 1
    end

    def is_not_digit?(marker)
      /[a-zA-Z]/.match(marker) ? true : false
    end

    def valid_move(move, size)
      total_cell_nums = size * size
      is_cell_within_range?(move, total_cell_nums)
    end

    def is_cell_within_range?(move, total_cell_nums)
      move > 0 && move <= total_cell_nums  
    end

    def translation(move, size)
      move -= 1
      x = move / size
      y = move % size
      {x: x, y: y}
    end
  end
end
