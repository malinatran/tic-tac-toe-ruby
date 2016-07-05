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
    let(:input)           { StringIO.new }
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

    context "#generate_markers" do
      it "creates an array of markers" do
        expect(game.generate_markers).to eq(["X", "O"])
      end
    end

    context "#run_game_loop" do
      it "calls methods to display board, select move, and make human move if current player is human" do 
        allow(TicTacToe).to receive(:is_game_over?).and_return(false, true)
        allow(game).to receive(:is_computer_the_current_player?).and_return(false)
        input.string = "1"
        expect(game).to receive(:make_human_move)
        expect(user_interface).to receive(:display_board)
        expect(user_interface).to receive(:display_outcome)
        game.run_game_loop
      end  

      it "calls a method to make the computer's move" do 
        allow(TicTacToe).to receive(:is_game_over?).and_return(false, true)
        allow(game).to receive(:is_computer_the_current_player?).and_return(true)
        expect(game).to receive(:make_computer_move)
        expect(user_interface).to receive(:display_board)
        expect(user_interface).to receive(:display_outcome)
        game.run_game_loop
      end

      it "calls several methods to display board and outcome regardless of current player" do
        allow(TicTacToe).to receive(:is_game_over?).and_return(true)
        expect(user_interface).to receive(:display_board)
        expect(game).to receive(:declare_outcome)
        expect(user_interface).to receive(:display_outcome)
        game.run_game_loop
      end
    end
  end
end
