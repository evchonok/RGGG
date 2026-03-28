# frozen_string_literal: true

require "test_helper"

class TestableSudoka < GoGameGem::Sudoka
  def initialize
  end
end

class TestSudoka < Minitest::Test
  def setup
    @game = TestableSudoka.new
  end

  def test_valid_coordinates_returns_true
    assert @game.send(:valid_coordinates?, 0, 0)
    assert @game.send(:valid_coordinates?, 4, 4)
    assert @game.send(:valid_coordinates?, 8, 8)
  end

  def test_invalid_coordinates_returns_false
    refute @game.send(:valid_coordinates?, -1, 0)
    refute @game.send(:valid_coordinates?, 9, 9)
    refute @game.send(:valid_coordinates?, 10, 10)
  end

  def test_game_won_when_board_full
    board = Array.new(9) { Array.new(9, 1) }
    assert @game.send(:game_won?, board)
  end

  def test_game_not_won_when_board_empty
    board = Array.new(9) { Array.new(9, 0) }
    refute @game.send(:game_won?, board)
  end

  def test_valid_move_on_empty_board
    board = Array.new(9) { Array.new(9, 0) }
    assert @game.send(:valid_move?, board, 0, 0, 5)
  end

  def test_invalid_move_same_row
    board = Array.new(9) { Array.new(9, 0) }
    board[0][5] = 5
    refute @game.send(:valid_move?, board, 0, 0, 5)
  end

  def test_generate_puzzle_returns_two_arrays
    board, solution = @game.send(:generate_puzzle)
    assert_instance_of Array, board
    assert_instance_of Array, solution
  end

  def test_generate_puzzle_has_empty_cells
    board, solution = @game.send(:generate_puzzle)
    empty_cells = board.flatten.count(0)
    assert empty_cells > 0
  end

  def test_parse_input_valid
    board = Array.new(9) { Array.new(9, 0) }
    row, col, num = @game.send(:parse_input, '1 1 5', board)
    assert_equal 0, row
    assert_equal 0, col
    assert_equal 5, num
  end

  def test_display_board_outputs_grid
    board = Array.new(9) { Array.new(9, 0) }
    output = capture_io do
      @game.send(:display_board, board)
    end
    assert output[0].include?('┌')
  end
end