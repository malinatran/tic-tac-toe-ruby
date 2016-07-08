module TicTacToe
  class Player

    attr_reader :marker

    def initialize(marker = nil)
      @marker = marker || default_marker
    end

    def default_marker
      nil
    end

    def make_move
      nil
    end
  end
end
