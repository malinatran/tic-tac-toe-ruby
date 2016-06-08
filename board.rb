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
      @size.times do |x|
        @size.times do |y|
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
      @size.times do |x|
        @size.times do |y|
          clear_cell(x, y)
        end
      end
    end

    def is_row_filled?(y, identity)
      self.grid[y].each do |cell|
        
      end
    end

    def is_col_filled?
    end

    def is_either_diagonal_filled?
    end

    def is_forward_diagonal_filled?
    end

    def is_backward_diagonal_filled?
    end

  end
end
