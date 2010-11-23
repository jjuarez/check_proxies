module CheckProxies
  class Logger
    include Singleton
    
    def initialize( )
      
      ldn = File.join( App::ROOT, 'log' )

      FileUtils.mkdir( ldn ) unless File.exist?( ldn )

      @log       = ::Logger.new( File.join( ldn, 'check_proxies.log' ) )
      @log.level = ::Logger::DEBUG
    end
    
    def error( message )
      @log.error( message )
    end
    
    def warn( message )
      @log.warn( message )
    end
    
    def info( message )
      @log.info( message )
    end
    
    def debug( message )
      @log.debug( message )
    end
  end
end