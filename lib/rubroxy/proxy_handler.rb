module Rubroxy
  module Handler
    class URLCapture

      attr_accessor :urls

      def initialize
        @urls = { uris: {} }
        proc do |req, res|
          write(req.unparsed_uri)
        end
      end

      def write(url)
        if @urls[:uris].key?(url)
          @urls[:uris][url] += 1
        else
          @urls[:uris].merge!({ url => 0 })
        end
      end
    end
  end
end