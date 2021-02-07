require 'rubygems'
require 'webrick'
require 'erb'
require 'pry'

Dir[File.join(__dir__, 'app/models', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'app/controllers', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'app/presenters', '*.rb')].each { |file| require file }

# Initialize our WEBrick server
if $0 == __FILE__ then
  server = WEBrick::HTTPServer.new(:Port => 8000)
  server.mount "/games/:id", GamesController
  server.mount "/games/new", GamesController
  server.mount "/games", GamesController
  server.mount "/", HomeController
  server.mount '/favicon.ico', WEBrick::HTTPServlet::FileHandler, 'public'
  server.mount '/css', WEBrick::HTTPServlet::FileHandler, 'public/css'
  server.mount '/javascript', WEBrick::HTTPServlet::FileHandler, 'public/javascript'
  server.mount '/assets', WEBrick::HTTPServlet::FileHandler, 'public/assets'
  trap "INT" do server.shutdown end
  server.start
end
