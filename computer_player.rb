require "./player"
require "./board"

module TicTacToe

  class NoCenterCellError < StandardError
  end

  class ComputerPlayer < Player
    attr_reader :identity, :board

    def initialize(params)
      @board = params.fetch(:board)
      super(params)
    end
    
    def default_identity
      "X"
    end

    def get_center_move
      size = board.get_size
      move = {}
      if size % 2 != 0
        center = size / 2
        move[:x] = move[:y] = center
        if board.is_cell_empty?(move[:x], move[:y])
          move
        end
      else
        raise NoCenterCellError, "Center cell does not exist due to board's size."
      end
    end

    def get_winning_move(identity)
      empty_cells = board.get_empty_cells
      empty_cells.each do |coordinates| 
        x = coordinates[:x].to_i
        y = coordinates[:y].to_i
        board.set_cell(x, y, identity)
        if board.is_row_filled?(x, identity) || 
          board.is_column_filled?(y, identity) || 
          board.is_either_diagonal_filled?(identity)
          board.clear_cell(x, y)
          move = {x: x, y: y}
          return move 
        else
          board.clear_cell(x, y)
        end
      end
    end

    def get_corner_move
      edge = board.get_size - 1
      corner_moves = [
        {:x=>0,:y=>0},
        {:x=>0,:y=>edge},
        {:x=>edge,:y=>0},
        {:x=>edge, :y=>edge}
      ]
      corner_moves.each do |corner| 
        if board.get_cell(corner[:x], corner[:y]).nil? 
          return corner 
        end
      end
      nil
    end

    def get_random_move
      empty_cells = board.get_empty_cells
      random_index = rand(empty_cells.length)
      empty_cells[random_index]
    end
  end
end
