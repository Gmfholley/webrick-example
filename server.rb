require 'rubygems'
require 'webrick'
require 'erb'
require 'pry'

Dir[File.join(__dir__, 'controllers', '*.rb')].each { |file| require file }

# Initialize our WEBrick server
if $0 == __FILE__ then

  server = WEBrick::HTTPServer.new(:Port => 8000)
  server.mount "/games/:id", GamesController
  server.mount "/games/new", GamesController
  server.mount "/games", GamesController
  server.mount "/", HomeController
  trap "INT" do server.shutdown end
  server.start
end
