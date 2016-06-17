module TicTacToe

  class CellIsFilledError < StandardError
  end

  class Board
    attr_reader :size, :grid
    
    def initialize(params = {})
      @size = params.fetch(:size, 3)
      @grid = create_grid(size)
    end

    def create_grid(size)
      Array.new(size) { Array.new(size) }
    end

    def get_size
      self.size
    end

    def is_cell_empty?(x, y)
      grid[x][y].nil?
    end

    def get_empty_cells
      empty_squares = []
      size = self.get_size
      size.times do |x|
        size.times do |y|
          if is_cell_empty?(x, y)
            empty_squares.push({x: x, y: y})
          end
        end
      end
      empty_squares
    end

    def is_grid_filled?
      self.get_empty_cells.length == 0
    end

    def get_cell(x, y)
      grid[x][y]
    end

    def set_cell(move, marker)
      x = move[:x]
      y = move[:y]
      if @grid[x][y].nil?
        @grid[x][y] = marker
      else 
        raise CellIsFilledError, "Cell already has a value."
      end
    end

    def clear_cell(x, y)
      grid[x][y] = nil
    end

    def clear_grid
      size = self.get_size
      size.times do |x|
        size.times do |y|
          clear_cell(x, y)
        end
      end
    end

    def is_row_filled?(x, marker)
      self.grid[x].each do |cell|
        if cell != marker
          return false
        end
      end
      true
    end

    def is_column_filled?(y, marker)
      self.grid.each do |cell|
        if cell[y] != marker
          return false
        end
      end
      true
    end

    def is_either_diagonal_filled?(marker)
      is_forward_diagonal_filled?(marker) || is_backward_diagonal_filled?(marker)
    end

    def is_forward_diagonal_filled?(marker)
      i = 0
      size = self.get_size
      while i < size
        if self.grid[i][size-1-i] != marker
          return false
        end
        i += 1
      end
      true
    end

    def is_backward_diagonal_filled?(marker)
      i = 0
      while i < self.get_size
        if self.grid[i][i] != marker
          return false
        end
        i += 1
      end
      true
    end
  end
end
