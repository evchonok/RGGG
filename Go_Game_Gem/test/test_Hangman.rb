# test/test_hangman.rb
# frozen_string_literal: true

require_relative "test_helper"

class TestHangman < Minitest::Test
  def setup
    @original_stdin = $stdin
    @original_stdout = $stdout
  end

  def teardown
    $stdin = @original_stdin
    $stdout = @original_stdout
  end

  def test_hangman_win_scenario
    input_data = "c\na\nt\n"
    $stdin = StringIO.new(input_data)

    output = capture_io do
      GoGameGem::Hangman.new("cat")
    end

    assert_match(/Поздравляем! Вы выиграли!/, output.join)
  end

  def test_hangman_lose_scenario
    input_data = "z\nx\nj\nq\nw\nk\n"
    $stdin = StringIO.new(input_data)

    output = capture_io do
      GoGameGem::Hangman.new("cat")
    end

    assert_match(/Игра окончена/, output.join)
  end

  def test_invalid_input_handling
    input_data = "1\nb\nb\nf\ng\nh\ni\nl\nm\n"
    $stdin = StringIO.new(input_data)

    output = capture_io do
      GoGameGem::Hangman.new("cat")
    end

    full_output = output.join
    
    assert_match(/Пожалуйста, введите одну букву/, full_output)
    assert_match(/Эта буква уже была угадана/, full_output)
    assert_match(/Игра окончена/, full_output)
  end
end