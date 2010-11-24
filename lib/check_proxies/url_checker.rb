module CheckProxies
  class URLChecker
    
    def self.check( proxy, url )
      
      proxy_uri = URI.parse( proxy )
      url       = URI.parse( url )
      request   = Net::HTTP::Get.new( url.path )
      
      Logger::instance.debug( "Checking: #{proxy_uri.host}:#{proxy_uri.port} / #{url}" )
      
      Net::HTTP::Proxy( proxy_uri.host, proxy_uri.port ).start( url.host, url.port ) do |http|
          
        return http.request( @request )
      end
    end
  end
end