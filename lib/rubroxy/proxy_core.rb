# :nodoc:
class Proxy
  attr_accessor :server

  def initialize(port)
    logger = Logger.new($stderr)
    logger.level = Logger::DEBUG
    @server = WEBrick::HTTPProxyServer.new(Port: port,
                                           Logger: logger)
  end

  def add_rules(handler)
    @server.server.config[:ProxyContentHandler] = handler
  end

  def start_server
    Signal.trap('INT') { stop_server }
    Signal.trap('TERM') { stop_server }

    @server.start
  end

  # Stops the proxy server
  def stop_server
    @server.shutdown
  end
end
