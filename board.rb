module TicTacToe
  class Board

    attr_reader :size, :grid
    
    def initialize(params = {})
      @size = params.fetch(:size, 3)
      @grid = create_grid(size)
    end

    def create_grid(size)
      Array.new(size) { Array.new(size) }
    end

    def get_grid
      self.grid
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

    def set_cell(x, y, identity)
      if grid[x][y].nil?
        grid[x][y] = identity
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

    def is_row_filled?(x, identity)
      self.grid[x].each do |cell|
        if cell != identity
          return false
        end
      end
      true
    end

    def is_column_filled?(y, identity)
      self.grid.each do |cell|
        if cell[y] != identity
          return false
        end
      end
      true
    end

    def is_forward_diagonal_filled?(identity)
      i = 0
      size = self.get_size
      while i < size
        if self.grid[i][size-1-i] != identity
          return false
        end
        i += 1
      end
      true
    end

    def is_backward_diagonal_filled?(identity)
      i = 0
      while i < self.get_size
        if self.grid[i][i] != identity
          return false
        end
        i += 1
      end
      true
    end

  end
end
