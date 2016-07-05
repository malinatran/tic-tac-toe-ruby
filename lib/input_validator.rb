module TicTacToe 
  class InputValidator

    def is_size_valid?(size)
      size <= 10 && size > 2
    end

    def is_marker_valid?(marker)
      marker.capitalize != "X" && marker.length == 1 ? true : false
    end

    def is_move_valid?(move, size)
      cell_nums = size * size
      move <= cell_nums && move > 0 ? true : false
    end
  end
end
