# frozen_string_literal: true

require_relative "test_helper"

class TestTicTacToe < Minitest::Test
  def test_winner_horizontal
    game = GoGameGem::TicTacToe.new
    
    def game.start_game; end
    
    board = [
      ["X", "X", "X"],
      [" ", " ", " "],
      [" ", " ", " "]
    ]
    
    assert game.send(:winner?, board)
  end

  def test_winner_vertical
    game = GoGameGem::TicTacToe.new
    def game.start_game; end
    
    board = [
      ["X", " ", " "],
      ["X", " ", " "],
      ["X", " ", " "]
    ]
    
    assert game.send(:winner?, board)
  end

  def test_winner_diagonal_main
    game = GoGameGem::TicTacToe.new
    def game.start_game; end
    
    board = [
      ["X", " ", " "],
      [" ", "X", " "],
      [" ", " ", "X"]
    ]
    
    assert game.send(:winner?, board)
  end

  def test_winner_diagonal_other
    game = GoGameGem::TicTacToe.new
    def game.start_game; end
    
    board = [
      [" ", " ", "O"],
      [" ", "O", " "],
      ["O", " ", " "]
    ]
    
    assert game.send(:winner?, board)
  end

  def test_no_winner_empty_board
    game = GoGameGem::TicTacToe.new
    def game.start_game; end
    
    board = [
      [" ", " ", " "],
      [" ", " ", " "],
      [" ", " ", " "]
    ]
    
    assert !game.send(:winner?, board)
  end

  def test_board_full
    game = GoGameGem::TicTacToe.new
    def game.start_game; end
    
    board = [
      ["X", "O", "X"],
      ["O", "X", "O"],
      ["O", "X", "X"]
    ]
    
    assert game.send(:board_full?, board)
  end

  def test_board_not_full
    game = GoGameGem::TicTacToe.new
    def game.start_game; end
    
    board = [
      ["X", "O", "X"],
      ["O", " ", "O"],
      ["O", "X", "X"]
    ]
    
    assert !game.send(:board_full?, board)
  end

  def test_game_over_by_winner
    game = GoGameGem::TicTacToe.new
    def game.start_game; end
    
    board = [
      ["X", "X", "X"],
      [" ", " ", " "],
      [" ", " ", " "]
    ]
    
    assert game.send(:game_over?, board)
  end

  def test_valid_coordinates
    game = GoGameGem::TicTacToe.new
    def game.start_game; end
    
    assert game.send(:valid_coordinates?, 0, 0)
    assert game.send(:valid_coordinates?, 1, 1)
    assert game.send(:valid_coordinates?, 2, 2)
  end

  def test_invalid_coordinates
    game = GoGameGem::TicTacToe.new
    def game.start_game; end
    
    assert !game.send(:valid_coordinates?, -1, 0)
    assert !game.send(:valid_coordinates?, 3, 3)
    assert !game.send(:valid_coordinates?, 0, 5)
  end
end