# frozen_string_literal: true

require_relative 'concerns/render_haml'

class ApplicationController < WEBrick::HTTPServlet::AbstractServlet
  include RenderHaml
  attr_reader :request, :response

  # Process the request, return response
  def do_GET(request, response)
    @request = request
    @response = response
    status, content_type, body = get_routes
    set_response(status, content_type, body)
  end

  def do_POST(request, response)
    @request = request
    @response = response

    status, content_type, body = post_routes
    set_response(status, content_type, body)
  end

  def redirect_to(url, status: 302)
    response.set_redirect(WEBrick::HTTPStatus[status], url)
  end

  def present(obj, klass = nil)
    klass ||= Object.const_get("#{obj.class.name}Presenter")
    klass.new(obj)
  end

  private

  def set_response(status, content_type, body)
    response.status = status
    response['Content-Type'] = content_type
    response.body = body
  end

  def get_routes
    if params[:id] && %r(/edit).match(request.request_uri.path)
      edit
    elsif params[:id]
      show
    elsif %r(/new).match(request.request_uri.path)
      new
    else
      index
    end
  end

  def post_routes
    if params[:id] && params[:_destroy]
      destroy
    elsif params[:id]
      update
    else
      create
    end
  end

  def params
    return @params if defined?(@params)

    id = request.request_uri.path[/\d+/]
    id = id.to_i if id
    @params = { id: id }.merge(request.query).compact.transform_keys(&:to_sym)
  end
end
