require 'socket'
require 'pry'
require './lib/output'
require './lib/response_parser'
require './lib/persistent_state'

class Server
  attr_accessor :server
  attr_reader :client

  def initialize
    @ps = PersistentState.new
    @server = TCPServer.new(9292)
  end

  def start
    puts "Ready for a request"
    loop do
      @client = server.accept

      request_lines = get_lines(client)
      @response = ResponseParser.new(request_lines)
      output_object = Output.new(@response, @ps)
      client.puts @ps.header
      output_object.path_outputs(client)
      @ps.header = ["http/1.1 #{@ps.response_code}",
        "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
        "server: ruby",
        "content-type: text/html; charset=iso-8859-1"].join("\r\n")

      @ps.guess = client.read(@response.content_length).to_i
  

      client.puts @ps.body
      client.close
      break if @ps.close

    end
  end

  def get_lines(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    request_lines
  end

end


if __FILE__ == $0
  s = Server.new
  s.start
end
