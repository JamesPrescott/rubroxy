# :nodoc:
class Proxy
  attr_accessor :server

  def initialize(port)
    logger = Logger.new($stderr)
    logger.level = Logger::DEBUG
    @server = WEBrick::HTTPProxyServer.new(Port: port,
                                           ProxyContentHandler: method(:handle_request),
                                           Logger: logger)
  end

  def handle_request(req, res)
    res.body = 'test' if req.host == 'qa.sit.dotcom.awseuwest1.itvcloud.zone'
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
