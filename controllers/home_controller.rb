# frozen_string_literal: true

require_relative 'application_controller'

class HomeController < ApplicationController
  # Process the request, return response
  def do_GET(request, response)
    status, content_type, body = home(request)

    response.status = status
    response['Content-Type'] = content_type
    response.body = body
  end

  # Construct the return HTML page
  def home(_request)
    @games = [1, 2, 3]
    render('games/index')
  end
end
