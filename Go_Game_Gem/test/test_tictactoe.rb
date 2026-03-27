# frozen_string_literal: true

require_relative "test_helper"

class TestTicTacToe < Minitest::Test
  def setup
    @game = GoGameGem::TicTacToe.new
  end

  def test_winner_horizontal
    board = [
      ["X", "X", "X"],
      [" ", " ", " "],
      [" ", " ", " "]
    ]
    
    assert @game.send(:winner?, board)
  end

  def test_winner_vertical
    board = [
      ["X", " ", " "],
      ["X", " ", " "],
      ["X", " ", " "]
    ]
    
    assert @game.send(:winner?, board)
  end

  def test_winner_diagonal_main
    board = [
      ["X", " ", " "],
      [" ", "X", " "],
      [" ", " ", "X"]
    ]
    
    assert @game.send(:winner?, board)
  end

  def test_winner_diagonal_other
    board = [
      [" ", " ", "O"],
      [" ", "O", " "],
      ["O", " ", " "]
    ]
    
    assert @game.send(:winner?, board)
  end

  def test_no_winner_empty_board
    board = [
      [" ", " ", " "],
      [" ", " ", " "],
      [" ", " ", " "]
    ]
    
    assert !@game.send(:winner?, board)
  end

  def test_board_full
    board = [
      ["X", "O", "X"],
      ["O", "X", "O"],
      ["O", "X", "X"]
    ]
    
    assert @game.send(:board_full?, board)
  end

  def test_board_not_full
    board = [
      ["X", "O", "X"],
      ["O", " ", "O"],
      ["O", "X", "X"]
    ]
    
    assert !@game.send(:board_full?, board)
  end

  def test_game_over_by_winner
    board = [
      ["X", "X", "X"],
      [" ", " ", " "],
      [" ", " ", " "]
    ]
    
    assert @game.send(:game_over?, board)
  end

  def test_game_over_by_full_board
    board = [
      ["X", "O", "X"],
      ["O", "X", "O"],
      ["O", "X", "X"]
    ]
    
    assert @game.send(:game_over?, board)
  end

  def test_valid_coordinates
    assert @game.send(:valid_coordinates?, 0, 0)
    assert @game.send(:valid_coordinates?, 1, 1)
    assert @game.send(:valid_coordinates?, 2, 2)
  end

  def test_invalid_coordinates
    assert !@game.send(:valid_coordinates?, -1, 0)
    assert !@game.send(:valid_coordinates?, 3, 3)
    assert !@game.send(:valid_coordinates?, 0, 5)
  end
end