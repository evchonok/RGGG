# frozen_string_literal: true

require_relative '../Go_Game_Gem/version'

module GoGameGem
  class Sudoka
    def initialize
      puts "Игра судоку запущена!"
      start_game
    end

    def play
      start_game
    end

    private

    def start_game
      loop do
        board, solution = generate_puzzle
        play_game(board, solution)

        puts "\nХотите сыграть ещё раз? (y/n)"
        break unless gets.chomp.downcase == 'y'

        puts "\n" * 2
        puts "Новая игра!"
      end

      puts "Спасибо за игру!"
    end

    def generate_puzzle
      solution = Array.new(9) { Array.new(9, 0) }
      fill_board(solution)
      board = solution.map(&:dup)
      cells_to_remove = 40
      removed = 0
      while removed < cells_to_remove
        row = rand(0..8)
        col = rand(0..8)
        if board[row][col] != 0
          board[row][col] = 0
          removed += 1
        end
      end
      [board, solution]
    end

    def fill_board(board)
      solution = [
        [1, 2, 3, 4, 5, 6, 7, 8, 9],
        [4, 5, 6, 7, 8, 9, 1, 2, 3],
        [7, 8, 9, 1, 2, 3, 4, 5, 6],
        [2, 3, 4, 5, 6, 7, 8, 9, 1],
        [5, 6, 7, 8, 9, 1, 2, 3, 4],
        [8, 9, 1, 2, 3, 4, 5, 6, 7],
        [3, 4, 5, 6, 7, 8, 9, 1, 2],
        [6, 7, 8, 9, 1, 2, 3, 4, 5],
        [9, 1, 2, 3, 4, 5, 6, 7, 8]
      ]

      10.times do
        case rand(4)
        when 0
          swap_rows_in_block!(solution)
        when 1
          swap_cols_in_block!(solution)
        when 2
          swap_row_blocks!(solution)
        when 3
          swap_col_blocks!(solution)
        end
      end

      (0..8).each do |row|
        (0..8).each do |col|
          board[row][col] = solution[row][col]
        end
      end
    end

    def swap_rows_in_block!(board)
      block = [0, 3, 6].sample
      rows = [block, block + 1, block + 2].sample(2)
      board[rows[0]], board[rows[1]] = board[rows[1]], board[rows[0]]
    end

    def swap_cols_in_block!(board)
      block = [0, 3, 6].sample
      col1, col2 = [block, block + 1, block + 2].sample(2)
      (0..8).each do |row|
        board[row][col1], board[row][col2] = board[row][col2], board[row][col1]
      end
    end

    def swap_row_blocks!(board)
      blocks = [0, 3, 6].sample(2)
      blocks[0], blocks[1] = blocks[1], blocks[0]
      3.times do |i|
        board[blocks[0] + i], board[blocks[1] + i] = board[blocks[1] + i], board[blocks[0] + i]
      end
    end

    def swap_col_blocks!(board)
      blocks = [0, 3, 6].sample(2)
      (0..8).each do |row|
        3.times do |i|
          board[row][blocks[0] + i], board[row][blocks[1] + i] = 
          board[row][blocks[1] + i], board[row][blocks[0] + i]
        end
      end
    end

    def play_game(board, solution)
      moves_count = 0
      until game_won?(board)
        display_board(board)
        puts "Ходов сделано: #{moves_count}"
        puts "Введите строку, потом столбец и потом цифру через пробел"
        puts "Или введите 'quit' для выхода"

        input = gets.chomp.downcase

        if input == 'quit'
          puts "Игра прервана. Решение было:"
          display_board(solution)
          return
        end

        row, col, num = parse_input(input, board)
        next unless row && col && num

        if board[row][col] != 0
          puts "Эта клетка уже заполнена!"
          next
        end

        board[row][col] = num
        moves_count += 1

        if num != solution[row][col]
          puts "Неверный ход!"
          board[row][col] = 0
        elsif game_won?(board)
          display_board(board)
          puts "Поздравляем! Вы решили судоку за #{moves_count} ходов!"
        end
      end
    end

    def display_board(board)
      puts "\n"
      puts "  ┌───────┬───────┬───────┐"
      
      board.each_with_index do |row, i|
        if i > 0 && i % 3 == 0
          puts "  ├───────┼───────┼───────┤"
        end
        
        line = "  │"
        row.each_with_index do |cell, j|
          if j > 0 && j % 3 == 0
            line += " │"
          end
          
          value = cell == 0 ? " ." : " #{cell}"
          line += value
        end
        line += " │"
        puts line
      end
      
      puts "  └───────┴───────┴───────┘"
      puts "\n"
    end

    def parse_input(input, board)
      parts = input.split
      if parts.length != 3
        puts "Пожалуйста, введите три значения: строка столбец цифра"
        return [nil, nil, nil]
      end
      row = parts[0].to_i - 1
      col = parts[1].to_i - 1
      num = parts[2].to_i
      if !valid_coordinates?(row, col)
        puts "Пожалуйста, введите числа от 1 до 9 для строки и столбца."
        return [nil, nil, nil]
      end
      if num < 1 || num > 9
        puts "Пожалуйста, введите цифру от 1 до 9."
        return [nil, nil, nil]
      end
      [row, col, num]
    end

    def valid_coordinates?(row, col)
      row.between?(0, 8) && col.between?(0, 8)
    end

    def valid_move?(board, row, col, num)
      return false if board[row].include?(num)
      (0..8).each do |i|
        return false if board[i][col] == num
      end
      box_row = (row / 3) * 3
      box_col = (col / 3) * 3
      (0..2).each do |i|
        (0..2).each do |j|
          return false if board[box_row + i][box_col + j] == num
        end
      end
      true
    end

    def game_won?(board)
      board.all? { |row| row.none? { |cell| cell == 0 } }
    end
  end
end