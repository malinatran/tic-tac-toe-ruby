module TicTacToe
  class Player

    MARKERS = ["X", "O"]

    attr_reader :marker

    def initialize(marker = nil)
      @marker = marker || default_marker
    end

    def default_marker
      nil
    end
  end
end
