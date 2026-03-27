# frozen_string_literal: true

require_relative "Go_Game_Gem/version"
require_relative "Games/hangman"
require_relative "Games/tictactoe"
require_relative "Games/Sudoka"

module GoGameGem
  class Error < StandardError; end
    def self.start
      puts "Добро пожаловать в мини-игры!"
      puts "Выберите игру:"
      puts "1. Виселица"
      puts "2. Крестики_нолики"
      puts "3. Судоку"
      print "Введите номер игры: "

      choice = gets.chomp.to_i

      case choice
      when 1
        Hangman.new
      when 2
        TicTacToe.new
      when 3
        Sudoka.new
      else
        puts "Некорректный выбор."
      end
    end

end