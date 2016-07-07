require_relative "constants"

module TicTacToe

  class CellIsFilledError < StandardError
  end

  class Board
    attr_reader :size, :grid

    def initialize(size = nil)
      @size = size || DEFAULT_SIZE 
      @grid = create_grid
    end

    def size=(size)
      @size = size
      @grid = create_grid
    end

    def get_empty_cells
      empty_squares = []

      @size.times do |x|
        @size.times do |y|
          if is_cell_empty?({x: x, y: y})
            empty_squares << {x: x, y: y}
          end
        end
      end

      empty_squares
    end

    def is_grid_filled?
      get_empty_cells.length == 0
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

    def clear_cell(move)
      @grid[move[:x]][move[:y]] = nil
    end

    def clear_grid
      @size.times do |x|
        @size.times do |y|
          clear_cell({x: x, y: y})
        end
      end
    end

    def retrieve_cells(marker)
      player_cells = []

      @size.times do |x|
        @size.times do |y|
          if @grid[x][y] == marker 
            player_cells << {x: x, y: y}
          end
        end
      end

      player_cells
    end

    def is_row_filled?(x, marker)
      @grid[x].each do |cell|
        if cell != marker
          return false
        end
      end

      true
    end

    def is_column_filled?(y, marker)
      @grid.each do |row|
        if row[y] != marker
          return false
        end
      end

      true
    end

    def is_either_diagonal_filled?(marker)
      is_forward_diagonal_filled?(marker) || is_backward_diagonal_filled?(marker)
    end

    private

    def create_grid
      Array.new(@size) { Array.new(@size) }
    end
    
    def is_cell_empty?(move)
      @grid[move[:x]][move[:y]].nil?
    end
    
    def is_forward_diagonal_filled?(marker)
      i = 0

      while i < @size
        if @grid[i][@size-1-i] != marker
          return false
        end
        i += 1
      end

      true
    end

    def is_backward_diagonal_filled?(marker)
      i = 0

      while i < @size
        if @grid[i][i] != marker
          return false
        end
        i += 1
      end
      
      true
    end
  end
end
