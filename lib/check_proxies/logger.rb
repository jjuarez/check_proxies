require 'logger'


module CheckProxies
  class Logger
    include Singleton
    
    def initialize( )
      @log       = ::Logger.new( File.join( App::ROOT, 'log', "#{App::NAME}.log" ) )
      @log.level = ::Logger::DEBUG
    end
    
    def fatal( message )
      @log.error( message )
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