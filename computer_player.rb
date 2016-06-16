require "./player"
require "./board"

module TicTacToe

  class ComputerPlayer < Player
    attr_reader :marker, :board

    # def post_initialize(params)
      # @board = params[:board]
    # end
    
    # def default_marker
      # MARKERS[0]
    # end
    
    def request_move(params)
      @board = params[:board]
      @size = params[:size] || 3
      @marker = params[:marker]
      moves = [self.get_center_move(@size),
               self.get_winning_move(@marker),
               self.get_corner_move,
               self.get_random_move]
      i = 0
      move = [] 
      while move.length == 0 do
        if moves[i] != nil
          return moves[i]
        end
        i += 1
      end
    end

    def get_center_move(size)
      move = {}
      if size % 2 != 0
        center = size / 2
        move[:x] = move[:y] = center
        if @board.is_cell_empty?(move[:x], move[:y])
          move
        end
      else
        nil
      end
    end

    def get_winning_move(marker)
      empty_cells = @board.get_empty_cells
      empty_cells.each do |coordinates| 
        x = coordinates[:x].to_i
        y = coordinates[:y].to_i
        @board.set_cell(x, y, marker)
        if @board.is_anything_filled?(x, y, marker) 
          @board.clear_cell(x, y)
          move = {x: x, y: y}
          return move 
        else
          @board.clear_cell(x, y)
        end
      end
      nil
    end

    def get_corner_move
      edge = @board.get_size - 1
      corner_moves = [
        {:x=>0,:y=>0},
        {:x=>0,:y=>edge},
        {:x=>edge,:y=>0},
        {:x=>edge, :y=>edge}
      ]
      corner_moves.each do |corner| 
        if @board.get_cell(corner[:x], corner[:y]).nil? 
          return corner 
        end
      end
      nil
    end

    def get_random_move
      empty_cells = @board.get_empty_cells
      random_index = rand(empty_cells.length)
      empty_cells[random_index]
    end
  end
end
