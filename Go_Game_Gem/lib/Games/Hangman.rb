# frozen_string_literal: true

require_relative '../Go_Game_Gem/version'

module GoGameGem
  class Hangman
    HANGMAN_STAGES = [
      "
       _______
      |/      |
      |
      |
      |
      |
      |___
      ",
      "
       _______
      |/      |
      |      (_)
      |
      |
      |
      |___
      ",
      "
       _______
      |/      |
      |      (_)
      |       |
      |       |
      |
      |___
      ",
      "
       _______
      |/      |
      |      (_)
      |      \\|
      |       |
      |
      |___
      ",
      "
       _______
      |/      |
      |      (_)
      |      \\|/
      |       |
      |
      |___
      ",
      "
       _______
      |/      |
      |      (_)
      |      \\|/
      |       |
      |      / 
      |___
      ",
      "
       _______
      |/      |
      |      (_)
      |      \\|/
      |       |
      |      / \\
      |___
      "
    ]

    def initialize(test_word = nil)
      puts "Игра виселица запущена!"
      @test_word = test_word
      start_game
    end

    private

    def start_game
      file_path = File.join(__dir__, 'words.txt')
      word = @test_word || File.readlines(file_path, chomp: true).sample
      guessed_letters = []
      attempts_left = 6
      display_word = Array.new(word.length, "_")

      until attempts_left.zero? || !display_word.include?("_")
        puts "\nТекущее слово: #{display_word.join(' ')}"
        puts "Осталось попыток: #{attempts_left}"
        draw_hangman(6 - attempts_left)
        print "Введите букву: "
        input = gets.chomp.downcase

        if input.length != 1 || !input.match?(/\A[a-z]\z/)
          puts "Пожалуйста, введите одну букву."
          next
        end

        if guessed_letters.include?(input)
          puts "Эта буква уже была угадана."
          next
        end

        guessed_letters << input

        if word.include?(input)
          puts "Верно!"
          word.chars.each_with_index do |char, index|
            if char == input
              display_word[index] = input
            end
          end
        else
          puts "Неверно!"
          attempts_left -= 1
        end
      end

      draw_hangman(6 - attempts_left)

      if !display_word.include?("_")
        puts "Поздравляем! Вы выиграли! Загаданное слово: #{word}"
      else
        puts "Игра окончена. Загаданное слово было: #{word}"
      end
    end

    def draw_hangman(stage)
      puts HANGMAN_STAGES[stage]
    end
  end
end