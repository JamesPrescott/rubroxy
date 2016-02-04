# :nodoc:
class Proxy
  attr_accessor :server

  def initialize(host, port, logger_level = 2)
    logger = Logger.new($stderr)
    logger.level = logger_level
    access_log = [] if logger.level >= 2
    @server = WEBrick::HTTPProxyServer.new(Port: port,
                                           Logger: logger,
                                           AccessLog: access_log,
                                           BindAddress: host)
  end

  def add_rules(handler)
    @server.config[:ProxyContentHandler] = handler
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
