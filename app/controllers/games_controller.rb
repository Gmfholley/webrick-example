# frozen_string_literal: true

require_relative 'application_controller'

class GamesController < ApplicationController
  def new
    render 'games/new'
  end

  def create
    @game = Game.new(player: params[:name], word: Word.random.name).tap(&:save)
    redirect_to "/games/#{@game.id}"
  end

  def show
    @game = present(Game.find(params[:id]))
    render 'games/show'
  end

  def update
    @game = present(Game.find(params[:id]))
    @game.guess(letter: params[:guess], whole_word: params[:word])
    @game.save
    render 'games/show'
  end
end
