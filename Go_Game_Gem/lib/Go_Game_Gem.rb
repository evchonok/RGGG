# frozen_string_literal: true

require_relative "Go_Game_Gem/version"
require_relative "Games/hangman"
require_relative "Games/tictactoe"

module GoGameGem
  class Error < StandardError; end
    def self.start
      puts "Добро пожаловать в мини-игры!"
      puts "Выберите игру:"
      puts "1. Виселица"
      puts "2. Крестики_нолики"
      puts "3. Игра 3 (её нужно добавить)"
      print "Введите номер игры: "

      choice = gets.chomp.to_i

      case choice
      when 1
        Hangman.new
      when 2
        TicTacToe.new
      when 3
        # Тут вызов другого класса игры
        puts "Игра 3 пока не реализована."
      else
        puts "Некорректный выбор."
      end
    end

end