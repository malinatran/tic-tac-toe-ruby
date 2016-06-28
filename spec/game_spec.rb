require_relative "spec_helper"
require_relative "../lib/game"

module TicTacToe
  describe TicTacToe::Game do

    let(:board)           { Board.new }
    let(:computer_player) { ComputerPlayer.new }
    let(:human_player)    { HumanPlayer.new }
    let(:user_interface)  { UserInterface.new(helper) }
    let(:game)            { Game.new(board: board, 
                                     computer_player: computer_player, 
                                     human_player: human_player,
                                     user_interface: user_interface) }
    let(:input)           { StringIO.new }
    let(:output)          { StringIO.new }
    let(:helper)          { Helper.new(input, output) }

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
    
    context "#start_game" do
      it "calls several methods when user provides custom size and marker" do
        options = { size: 3, marker: "F" }
        allow(user_interface).to receive(:get_options).and_return(options, nil)
        expect(game).to receive(:set_options)
        expect(game).to receive(:run_game_loop)
        game.start_game
      end
    end

    context "#set_options" do
      it "sets new size in board and new marker in human player" do
        game.instance_variable_set(:@size, 4)
        game.instance_variable_set(:@marker, "L")
        board.size = 4
        human_player.marker = "L"
        expect(board.size).to eq(4)
        expect(human_player.marker).to eq("L")
        game.set_options
      end
    end

    context "#run_game_loop" do
      it "displays the board when current player is human player" do 
        game.instance_variable_set(:@current_player, human_player)
        input.string = "1"
        allow(game).to receive(:is_game_over?).and_return(false, true)
        expect(user_interface).to receive(:display_board).exactly(2).times
        game.run_game_loop
      end  

      it "calls a method to make human for move" do 
        game.instance_variable_set(:@current_player, human_player)
        allow(game).to receive(:is_game_over?).and_return(false, true)
        input.string = "1"
        allow(user_interface).to receive(:select_move).and_return(1)
        expect(game).to receive(:make_human_move)
        game.run_game_loop
      end

      it "calls a method to make the computer's move" do 
        game.instance_variable_set(:@current_player, computer_player)
        allow(game).to receive(:is_game_over?).and_return(false, true)
        expect(game).to receive(:make_computer_move)
        game.run_game_loop
      end
    end

    context "#make_computer_move" do
      it "sets call methods to request and make move on the board and switch player" do
        expect(game).to receive(:request_computer_move).with(no_args)
        expect(board).to receive(:set_cell)
        expect(game).to receive(:switch_player)
        game.make_computer_move
      end
    end

    context "#make_human_move" do
      it "calls methods to map move and set cell and switch player" do
        move = {x: 0, y: 1} 
        expect(board).to receive(:set_cell)
        expect(game).to receive(:switch_player)
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
