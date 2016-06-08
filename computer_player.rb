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

    def request_move
    end

    def get_center_move
      move = {}
      center = board.get_size / 2
      move[:x] = move[:y] = center
      if board.is_cell_empty?(move[:x], move[:y])
        move
      end
    end

    def get_winning_move
    end

    def get_corner_move
    end

    def get_random_move

    end
  end
end
