# Core of the proxy. Handles the running and general methods
class Proxy
  # Starts the proxy server
  attr_accessor :server

  def initialize(port)
    handler = proc { yield }
    @server = WEBrick::HTTPProxyServer.new(Port: port,
                                           ProxyContentHandler: handler)
  end

  def start
    Signal.trap('INT') { stop }
    Signal.trap('TERM') { stop }

    @server.start
  end

  # Stops the proxy server
  def stop
    @server.shutdown
  end
end
