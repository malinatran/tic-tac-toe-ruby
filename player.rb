module TicTacToe
  class Player
    attr_reader :identity

    def initialize(params = {})
      @identity = params.fetch(:id, default_identity)
    end

    def default_identity
      raise NotImplementedError
    end
  end
end
