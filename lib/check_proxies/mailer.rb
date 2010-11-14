module CheckProxies
  class Mailer
    include Singleton
    
    def initialize()
      Logger::instance.debug( "Not implemented...yet" )
    end
  end
end