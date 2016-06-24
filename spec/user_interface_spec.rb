require_relative "spec_helper"
require_relative "../lib/user_interface"
require_relative "../lib/board"
require_relative "../lib/game"

module TicTacToe
  describe TicTacToe::UserInterface do

    let(:input) { StringIO.new }
    let(:output) { StringIO.new }
    let(:user_interface) { UserInterface.new(input, output) }
    let(:board) { Board.new(3) }
    let(:human_player) { HumanPlayer.new("M") }
    let(:computer_player) { ComputerPlayer.new }
    let(:game) do
      user_interface.instance_variable_get(:@game) || Game.new(
        board: board,
        human_player: human_player,
        computer_player: computer_player)
    end

    context "#run_menu_loop" do
      it "should display a welcome message and menu" do
        user_interface.instance_variable_set(:@quit_game, true)
        allow(user_interface).to receive(:get_input)
        expect(user_interface).to receive(:display).exactly(2).times
        user_interface.run_menu_loop
      end
    end

    context "#initialize_game" do
      it "should set the board size" do
        user_interface.instance_variable_set(:@size, 5)
        user_interface.initialize_game
        expect(game.board.size).to eq(5)
      end

      it "should set the human player marker" do
        user_interface.instance_variable_set(:@marker, "Y")
        user_interface.initialize_game
        expect(game.human_player.marker).to eq("Y")
      end
    end

    context "#run_game_loop" do
      it "should display the board when current player is human player" do 
        user_interface.instance_variable_set(:@game, game)
        game.instance_variable_set(:@current_player, game.human_player)
        input.string = "1"
        allow(game).to receive(:is_game_over?).and_return(false, true)
        expect(user_interface).to receive(:display_board).exactly(2).times
        user_interface.run_game_loop
      end  

      it "should ask human to make move" do 
        user_interface.instance_variable_set(:@game, game)
        game.instance_variable_set(:@current_player, game.human_player)
        input.string = "1"
        allow(game).to receive(:is_game_over?).and_return(false, true)
        allow(game).to receive(:make_human_move)
        expect(user_interface).to receive(:select_move)
        user_interface.run_game_loop
      end

      it "should call a method to make the human's move" do 
        user_interface.instance_variable_set(:@game, game)
        game.instance_variable_set(:@current_player, game.human_player)
        input.string = "1"
        allow(game).to receive(:is_game_over?).and_return(false, true)
        expect(game).to receive(:make_human_move).with(1)
        user_interface.run_game_loop
      end

      it "should call a method to make the computer's move" do 
        user_interface.instance_variable_set(:@game, game)
        game.instance_variable_set(:@current_player, game.computer_player)
        allow(game).to receive(:is_game_over?).and_return(false, true)
        expect(game).to receive(:make_computer_move)
        user_interface.run_game_loop
      end
    end

    context "#perform_menu_action" do
      it "should call a method to select a marker when an option is selected" do
        menu_option = "2"
        expect(user_interface).to receive(:select_marker)
        user_interface.perform_menu_action(menu_option)
      end
    end

    context "#select_size" do
      it "should return the size if input is valid" do
        input.string = "5"
        allow(user_interface).to receive(:is_size_valid?).and_return(true)
        expect(user_interface.select_size).to eq(5)
      end
    end

    context "#select_marker" do
      it "should return the marker if input is valid" do
        input.string = "Y"
        allow(user_interface).to receive(:is_marker_valid?).and_return(true)
        expect(user_interface.select_marker).to eq("Y")
      end
    end

    context "#select_move" do
      it "should return the move if input is valid" do
        input.string = "5"
        allow(user_interface).to receive(:is_move_valid?).and_return(true)
        expect(user_interface.select_move).to eq(5)
      end
    end

    context "#display_board" do
      it "should call a method to display the baord" do
        user_interface.instance_variable_set(:@game, game)
        expect(user_interface).to receive(:display)
        user_interface.display_board
      end

      it "should render a default 3x3 board with each cell's numerical value" do
        user_interface.instance_variable_set(:@game, game)
        expect(user_interface).to receive(:display).with("\n", "1 | 2 | 3\n4 | 5 | 6\n7 | 8 | 9\n", "\n")
        user_interface.display_board
      end
    end

    context "#display_outcome" do
      it "should display message about whether there is a draw or winner" do
        user_interface.instance_variable_set(:@game, game)
        allow(game).to receive(:declare_outcome).and_return("draw")
        expect(user_interface).to receive(:display).and_return("Nobody won!\n")
        user_interface.display_outcome
      end
    end
  end
end
