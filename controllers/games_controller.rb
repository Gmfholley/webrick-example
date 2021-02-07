# frozen_string_literal: true

require_relative 'application_controller'

class GamesController < ApplicationController

  # Process the request, return response
  def do_GET(request, response)
    if /\/games\/\d+/.match(request.request_uri.path)
      status, content_type, body = show(request)
    else
      status, content_type, body = new_game(request)
    end

    response.status = status
    response['Content-Type'] = content_type
    response.body = body
  end

  def do_POST(request, response)
    @game = create_game(request)
    response.set_redirect(WEBrick::HTTPStatus::Created, "/games/#{@game.id}")
  end

  def do_PATCH(request, response)
    @game = update_game(request)
    response.set_redirect(WEBrick::HTTPStatus::Created, "/games/#{@game.id}")
  end

  # Save POST request into a text file
  def new_game(_request)
    render 'games/new'
  end

  def create_game(request)
    Game.new(id: 4, player: "Wendy", word: "tests")
  end

  def show(request)
    id = request.request_uri.path[/\d+/].to_i
    @game = Game.new(id: id, player: 'Wendy', word: "tests")
    render "games/show"
  end
end
