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

    def is_cell_empty?(x, y)
      grid[x][y].nil?
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
  end
end