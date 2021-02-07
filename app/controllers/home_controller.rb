# frozen_string_literal: true

require_relative 'application_controller'

class HomeController < ApplicationController
  def index
    @games_length = Game.count
    render 'games/index'
  end
end
