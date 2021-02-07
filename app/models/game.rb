# frozen_string_literal: true

require_relative "model"

class Game < Model
  attr_accessor :id, :player, :word, :guesses

  def initialize(id: nil, player: nil, word: nil, guesses: [])
    @id = id
    @player = player
    @word = word
    @guesses = guesses
  end

  def guess(letter:, whole_word:)
    @guesses << letter if letter
    return unless whole_word

    if matches?(whole_word)
      @guesses += whole_word.downcase.split('').uniq
    else
      # The whole word takes up a guess, and they lose an option
      @guesses << whole_word
    end
  end

  def matches?(whole_word)
    whole_word.downcase == word.downcase
  end
end
