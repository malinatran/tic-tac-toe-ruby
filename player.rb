module TicTacToe
  
  MARKERS = ["X", "O"]

  class Player
    attr_reader :identity

    def initialize(params = {})
      @marker = params.fetch(:marker, default_marker)
    end

    def default_marker
      raise NotImplementedError
    end
  end
end
