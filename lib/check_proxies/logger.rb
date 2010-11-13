require 'logger'
require 'singleton'


module CheckProxies
  class Logger
    include Singleton
    
    attr_reader :log
    
    def initialize( )

      log_file_name = File.join( ROOT_APP, 'log', 'check_proxies.log' )
      @log          = ::Logger.new( log_file_name )
      @log.level    = ::Logger::DEBUG
    end
  end
end