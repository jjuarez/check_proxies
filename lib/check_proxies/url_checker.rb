module CheckProxies
  class URLChecker
    
    def check
      Logger::instance.debug( "Checking: #{@proxy_uri} -> #{@url}..." )
      
      Net::HTTP::Proxy( @proxy_uri.host, @proxy_uri.port ).start( @url.host, @url.port ) do |http|
          
        return http.request( @request )
      end
    rescue Exception => e
      Logger::instance.error e.message                            
      false 
    end
    
    def initialize( proxy, url )      
      @proxy_uri = URI.parse( proxy =~ /^http:\/\// ? proxy : "http://#{proxy}"  )
      @url       = URI.parse( url )
      @request   = Net::HTTP::Get.new( @url.path )
    rescue URI::InvalidURIError => e
      Logger::instance.error e.message
    end
  end
end