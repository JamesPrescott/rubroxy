# Main class of the proxy object, includes control methods
class Proxy
  attr_accessor :server

  # Creates the proxy object, defines logging levels and host:port
  #
  # @param host [String] Hostname of the proxy (eg: localhost, 127.0.0.1 etc)
  # @param port [Integer] The expected port number (eg: 8080)
  # @param logger_level [Integer] Sets the detail of the logger included.
  # @return [Proxy]
  def initialize(host, port, logger_level = 1)
    logger = Logger.new($stderr)
    logger.level = logger_level
    access_log = [] if logger.level == 3
    @server = WEBrick::HTTPProxyServer.new(Port: port,
                                           Logger: logger,
                                           AccessLog: access_log,
                                           BindAddress: host)
  end

  # Adds a Proc object to the Proxy server
  #
  # @param handler [Proc] The proc object to be passed into the server config
  def add_rules(handler)
    @server.config[:ProxyContentHandler] = handler
  end

  # Starts the server process, including traps for process termination
  def start_server
    Signal.trap('INT') { stop_server }
    Signal.trap('TERM') { stop_server }

    @server.start
  end

  # Shuts down the proxy server
  def stop_server
    @server.shutdown
  end
end
