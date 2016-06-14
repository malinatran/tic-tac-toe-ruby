module TicTacToe
  
  MARKERS = ["X", "O"]

  class Player
    attr_reader :identity

    def initialize(params = {})
      @marker = params.fetch(:marker, default_marker)
      post_initialize(params)
    end

    def post_initialize(params)
      nil
    end

    def default_marker
      raise NotImplementedError
    end
  end
end
