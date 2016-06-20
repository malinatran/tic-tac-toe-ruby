require_relative "player"
require_relative "board"

module TicTacToe

  class ComputerPlayer < Player
    attr_reader :marker

    def default_marker
      MARKERS[0]
    end

    def request_move(board, opponent_marker)
      @opponent_marker = opponent_marker
      moves = [self.get_center_move(board),
               self.get_winning_move(board, marker),
               self.get_winning_move(board, @opponent_marker),
               self.get_corner_move(board),
               self.get_random_move(board)]
      i = 0
      move = [] 
      while move.length == 0 do
        if moves[i] != nil
          return moves[i]
        end
        i += 1
      end
    end

    def get_center_move(board)
      move = {}
      if board.size % 2 != 0
        center = board.size / 2
        move[:x] = move[:y] = center
        if board.is_cell_empty?(move)
          move
        end
      else
        nil
      end
    end

    def get_winning_move(board, marker)
      empty_cells = board.get_empty_cells
      empty_cells.each do |coordinates| 
        board.set_cell(coordinates, marker)
        x = coordinates[:x]
        y = coordinates[:y]
        if board.is_row_filled?(x, marker) || 
          board.is_column_filled?(y, marker) || 
          board.is_either_diagonal_filled?(marker)
          board.clear_cell({x: x, y: y})
          move = {x: x, y: y}
          return move 
        else
          board.clear_cell({x: x, y: y})
        end
      end
      nil
    end

    def get_corner_move(board)
      edge = board.size - 1
      corner_moves = [{x: 0,    y: 0},
                      {x: 0,    y: edge},
                      {x: edge, y: 0},
                      {x: edge, y: edge}]
      corner_moves.each do |corner| 
        if board.grid[corner[:x]][corner[:y]].nil? 
          return corner 
        end
      end
      nil
    end

    def get_random_move(board)
      empty_cells = board.get_empty_cells
      random_index = rand(empty_cells.length)
      empty_cells[random_index]
    end
  end
end
