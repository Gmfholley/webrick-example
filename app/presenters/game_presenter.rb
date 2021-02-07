# frozen_string_literal: true

class GamePresenter < SimpleDelegator
  def display_letter(letter)
    return letter if reveal_letter?(letter)

    'X'
  end

  def game_status
    return 'You won!' if game_won?
    return 'You lost. :(' if game_lost?

    'Guess a new letter!'
  end

  def game_finished?
    word_revealed? || guesses.length >= max_guesses
  end

  def show_hint?
    !game_finished? && guesses.length + 1 == max_guesses
  end

  def hint
    'One more letter!  Want to guess the whole word?'
  end

  def max_guesses
    7
  end

  private

  def reveal_letter?(letter)
    guesses.map(&:downcase).include? letter.downcase
  end

  def game_won?
    game_finished? && word_revealed?
  end

  def game_lost?
    game_finished? && !game_won?
  end

  def word_revealed?
    word.split('').all? { |letter| reveal_letter?(letter) }
  end
end
