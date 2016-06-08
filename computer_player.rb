require "./board"

module TicTacToe
  class ComputerPlayer
    attr_reader :identity, :board
    def initialize(params)
      @identity = params.fetch(:id, "X")
      @board = params.fetch(:board)
    end

    def get_identity
      self.identity
    end

    def get_center_move
      size = board.get_size
      move = {}
      if size % 2 != 0
        center = size / 2
        move[:x] = move[:y] = center
        if board.is_cell_empty?(move[:x], move[:y])
          move
        # should I raise an error here?
        end
      else
        nil
      end
    end

    def get_winning_move
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
    end
  end
end
