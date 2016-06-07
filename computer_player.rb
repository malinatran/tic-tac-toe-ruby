module TicTacToe
  class ComputerPlayer
    attr_reader :identity
    def initialize(identity)
      @identity = identity
    end

    def get_identity
      self.identity
    end

    def request_move
    end

    def get_center_move
    end

    def get_winning_move
    end

    def get_corner_move
    end

    def get_random_move
      random_num = Random.rand(0..board.size)
      
    end
  end
end
