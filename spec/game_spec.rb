require_relative "spec_helper"
require_relative "../lib/game"

module TicTacToe
  describe TicTacToe::Game do

    let(:board)           { Board.new }
    let(:computer_player) { ComputerPlayer.new }
    let(:human_player)    { HumanPlayer.new }
    let(:user_interface)  { UserInterface.new(ui_helper, validator) }
    let(:game)            { Game.new(board: board, 
                                     computer_player: computer_player, 
                                     human_player: human_player,
                                     user_interface: user_interface) }
    let(:game_state)      { TicTacToe::GameState }
    let(:input)           { StringIO.new }
    let(:markers)         { ["X", "O", "G"] }
    let(:output)          { StringIO.new }
    let(:ui_helper)       { UserInterfaceHelper.new }
    let(:validator)       { InputValidator.new } 

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
  end
end
