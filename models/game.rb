# frozen_string_literal: true

class Game < Model
  attr_reader :id, :player, :word, :guesses

  def initialize(id:, player:, word:, guesses: [])
    @id = id
    @player = player
    @word = word
    @guesses = guesses
  end

  def guess(letter)
    @guesses << letter
  end
end
