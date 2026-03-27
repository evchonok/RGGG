# frozen_string_literal: true

require_relative '../Go_Game_Gem/version'

module GoGameGem
  class TicTacToe
    def initialize
      
    end
    
    def start
      puts "Игра крестики-нолики запущена!"
      start_game
    end

    private

    def start_game
      loop do
        board = Array.new(3) { Array.new(3, " ") }
        current_player = "X"
        
        play_game(board, current_player)
        
        puts "\nХотите сыграть ещё раз? (y/n)"
        break unless gets.chomp.downcase == 'y'
        
        puts "\n" * 2
        puts "Новая игра!"
      end
      
      puts "Спасибо за игру!"
    end

    def play_game(board, current_player)
      until game_over?(board)
        display_board(board)
        puts "Игрок #{current_player}, ваш ход:"

        row, col = get_player_move(board)

        board[row][col] = current_player
        if game_over?(board)
          display_board(board)
          if winner?(board)
            puts "Поздравляем! Игрок #{current_player} выиграл!"
          else
            puts "Ничья!"
          end
          break
        end
        current_player = current_player == "X" ? "O" : "X"
      end
    end

    def display_board(board)
      puts "\n"
      puts "    0   1   2"
      puts "   ┌───┬───┬───┐"
      board.each_with_index do |row, i|
        print " #{i} │"
        row.each do |cell|
          print " #{cell} │"
        end
        puts "\n   ├───┼───┼───┤" if i < 2
      end
      puts "\n   └───┴───┴───┘"
      puts "\n"
    end

    def get_player_move(board)
      loop do
        print "Введите строку и столбец (0-2) через пробел: "
        input = gets.chomp.split
        
        if input.length != 2
          puts "Пожалуйста, введите два числа."
          next
        end
        
        row = input[0].to_i
        col = input[1].to_i
        
        if !valid_coordinates?(row, col)
          puts "Пожалуйста, введите числа от 0 до 2."
          next
        end
        
        if board[row][col] != " "
          puts "Эта клетка уже занята. Выберите другую."
          next
        end
        
        return [row, col]
      end
    end

    def valid_coordinates?(row, col)
      row.between?(0, 2) && col.between?(0, 2)
    end

    def game_over?(board)
      winner?(board) || board_full?(board)
    end

    def winner?(board)
      # Проверка горизонталей
      (0..2).each do |i|
        if board[i][0] != " " && board[i][0] == board[i][1] && board[i][1] == board[i][2]
          return true
        end
      end
      
      # Проверка вертикалей
      (0..2).each do |j|
        if board[0][j] != " " && board[0][j] == board[1][j] && board[1][j] == board[2][j]
          return true
        end
      end
      
      # Проверка диагоналей
      if board[0][0] != " " && board[0][0] == board[1][1] && board[1][1] == board[2][2]
        return true
      end
      
      if board[0][2] != " " && board[0][2] == board[1][1] && board[1][1] == board[2][0]
        return true
      end
      
      false
    end

    def board_full?(board)
      board.all? { |row| row.none? { |cell| cell == " " } }
    end
  end
end