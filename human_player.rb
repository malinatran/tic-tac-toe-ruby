module TicTacToe
  class HumanPlayer
    attr_reader :identity
    def initialize(params = {})
      @identity = params.fetch(:id, "O")
    end

    def get_identity
      self.identity
    end

    def submit_move
    end
  end
end
