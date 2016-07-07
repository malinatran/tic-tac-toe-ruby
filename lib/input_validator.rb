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
      marker.capitalize != "X" && marker.length == 1
    end

    def valid_move(move, size)
      cell_nums = size * size
      move <= cell_nums && move > 0 ? true : false
    end

    def translation(move, size)
      move -= 1
      x = move / size
      y = move % size
      {x: x, y: y}
    end
  end
end
