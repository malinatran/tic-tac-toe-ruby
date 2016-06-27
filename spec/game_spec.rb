require_relative "spec_helper"
require_relative "../lib/game"

module TicTacToe
  describe TicTacToe::Game do
    let(:board) { Board.new }
    let(:computer_player) { ComputerPlayer.new }
    let(:human_player) { HumanPlayer.new }
    let(:game) { Game.new(board: board, 
                          computer_player: computer_player, 
                          human_player: human_player) }
    let(:current_player) { computer_player }
    let(:input) { StringIO.new }
    let(:output) { StringIO.new }
    let(:helper) { Helper.new(input, output) }
    let(:size) { 3 }
    let(:marker) { "M" }
    let(:user_interface) { UserInterface.new(size: size,
                                             marker: marker,
                                             helper: helper) } 

    context "#initialize" do
      it "initializes a game with a board" do
        sample_board = [[nil, nil, nil],
                        [nil, nil, nil],
                        [nil, nil, nil]]
        expect(board.grid).to eq(sample_board)
        expect(board.size).to eq(3)
      end

      it "initializes a game with a computer player and human player with default markers" do
        expect(computer_player.marker).to eq("X")
        expect(human_player.marker).to eq("O")
      end

      it "initializes a game with arguments that have been passed in" do
        board = Board.new(5)
        computer_player = ComputerPlayer.new("M")
        expect(board.size).to eq(5) 
        expect(computer_player.marker).to eq("M")
        expect(human_player.marker).to eq("O")
      end
    end
    
    context "#run_game_loop" do
      it "displays the board when current player is human player" do 
        game.instance_variable_set(:@current_player, game.human_player)
        input.string = "1"
        allow(game).to receive(:is_game_over?).and_return(false, true)
        expect(user_interface).to receive(:display_board).exactly(2).times
        game.run_game_loop
      end  

      it "asks human to make move" do 
        user_interface.instance_variable_set(:@game, game)
        game.instance_variable_set(:@current_player, game.human_player)
        input.string = "1"
        allow(game).to receive(:is_game_over?).and_return(false, true)
        allow(game).to receive(:make_human_move)
        expect(user_interface).to receive(:select_move)
        user_interface.run_game_loop
      end

      it "calls a method to make the human's move" do 
        user_interface.instance_variable_set(:@game, game)
        game.instance_variable_set(:@current_player, game.human_player)
        input.string = "1"
        allow(game).to receive(:is_game_over?).and_return(false, true)
        expect(game).to receive(:make_human_move).with(1)
        user_interface.run_game_loop
      end

      it "calls a method to make the computer's move" do 
        user_interface.instance_variable_set(:@game, game)
        game.instance_variable_set(:@current_player, game.computer_player)
        allow(game).to receive(:is_game_over?).and_return(false, true)
        expect(game).to receive(:make_computer_move)
        user_interface.run_game_loop
      end
    end

    context "#make_computer_move" do
      it "sets call methods to request and make move on the board" do
        expect(game).to receive(:request_computer_move).with(no_args)
        expect(board).to receive(:set_cell)
        game.make_computer_move
      end
    end

    context "#make_human_move" do
      it "calls methods to map move and set cell" do
        move = 3
        expect(board).to receive(:set_cell)
        game.make_human_move(move)
      end
    end

    context "#is_game_over?" do
      it "returns true if there is either a winner" do
        board.set_cell({x: 0, y: 0}, "X") 
        board.set_cell({x: 0, y: 1}, "X") 
        board.set_cell({x: 0, y: 2}, "X") 
        expect(game.is_game_over?).to eq(true)
      end

      it "returns true if there is a draw" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 0, y: 1}, "O")
        board.set_cell({x: 0, y: 2}, "O")
        board.set_cell({x: 1, y: 0}, "O")
        board.set_cell({x: 1, y: 1}, "X")
        board.set_cell({x: 1, y: 2}, "X")
        board.set_cell({x: 2, y: 0}, "X")
        board.set_cell({x: 2, y: 1}, "O")
        board.set_cell({x: 2, y: 2}, "O")
        expect(game.is_game_over?).to eq(true)
      end

      it "returns false if the game is still in session" do
        board.set_cell({x: 0, y: 0}, "X")
        board.set_cell({x: 0, y: 1}, "X")
        board.set_cell({x: 0, y: 2}, "O")
        expect(game.is_game_over?).to eq(false)
      end
    end

    context "#get_winner" do
      it "returns the winner" do
        board.set_cell({x: 0, y: 0}, "X") 
        board.set_cell({x: 0, y: 1}, "X") 
        board.set_cell({x: 0, y: 2}, "X") 
        expect(game.get_winner(computer_player)).to eq(computer_player)
      end

      it "returns nil if there is no winner" do
        board.set_cell({x: 0, y: 2}, "X") 
        expect(game.get_winner(human_player)).to eq(nil)
      end
    end

    context "#declare_outcome" do
      it "returns information about draw" do
        allow(game).to receive(:is_game_over?).and_return(true, false)
        allow(game).to receive(:draw?).and_return(true, false)
        expect(game.declare_outcome).to eq("draw")
      end

      it "returns information about winner" do
        allow(game).to receive(:is_game_over?).and_return(true, false)
        allow(game).to receive(:draw?).and_return(false)
        allow(game).to receive(:win?).and_return(true, false)
        expect(game).to receive(:declare_winner)
        game.declare_outcome
      end
    end
  end
end
