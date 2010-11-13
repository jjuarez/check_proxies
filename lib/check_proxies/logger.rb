require 'logger'
require 'singleton'


module CheckProxies
  class Logger
    include Singleton
    
    DEFAULT_LOG_FILE = "../../log/check_proxies.log"
    
    def initialize( )

      @log       = ::Logger.new( DEFAULT_LOG_FILE )
      @log.level = ::Logger::DEBUG
      
      self
    end
  end
end