require_relative "./board"

module TicTacToe
  class ComputerPlayer
    attr_reader :identity
    def initialize(params = {})
      @identity = params.fetch(:id, "X")
    end

    def get_identity
      self.identity
    end

    def request_move
    end

    def get_center_move
      center = Board.get_size / 2
      move = {x: center, y: center}
      if Board.is_cell_empty?(move.x, move.y)
        move
      end
    end

    def get_winning_move
    end

    def get_corner_move
    end

    def get_random_move
      random_num = Random.rand(0..Board.size)

    end
  end
end
