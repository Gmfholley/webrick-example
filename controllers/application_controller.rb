# frozen_string_literal: true

require_relative 'concerns/render_haml'

class ApplicationController < WEBrick::HTTPServlet::AbstractServlet
  include RenderHaml
end
