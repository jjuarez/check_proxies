module CheckProxies
  class URLChecker
    
    def check
      Logger::instance.debug( "Checking: #{@proxy_uri} -> #{@url}..." )
      Net::HTTP::Proxy( @proxy_uri.host, @proxy_uri.port ).start( @url ) { |http| ( http.get == Net::HTTPSucess ) }
    rescue => e
      Logger::instance.error e.message                            
      false 
    end
    
    def initialize( proxy, url )
      
      @proxy_uri = ( proxy =~ /^http:\/\// ) ? URI.parse( proxy ) : URI.parse( "http://#{proxy}" )
      @url       = url
    rescue URI::InvalidURIError => e
      Logger::instance.error e.message
    end
  end
end