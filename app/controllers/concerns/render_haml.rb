# frozen_string_literal: true

require 'erb'

# Common concern to add rendering function
module RenderHaml
  def render(template_name, status: 200, content_type: 'text/html', layout: 'layout')
    html = Template.new(template_name: template_name, bind: binding).render.to_s

    # Return OK (200), content-type: text/html, followed by the HTML itself
    [status, content_type, html]
  end

  # Rendering template class, to capture local binding
  class Template
    def initialize(template_name:, bind:, layout: 'layout')
      @template_name = "app/views/#{template_name}.html.haml"
      @bind = bind
      @layout = "app/views/#{layout}.html.haml"
    end

    def render
      layout.result(get_binding { |_| template })
    end

    private

    def erb_file(filename)
      ERB.new(File.read(filename))
    end

    def layout
      erb_file(@layout)
    end

    def template
      erb_file(@template_name).result(@bind)
    end

    # binding, the object, does not accept a block, but a method does
    # so just wrap binding in a method so you can send it a block
    def get_binding
      binding
    end
  end
end
