require 'uri'
require 'net/http'
require 'singleton'
require 'faster_csv'


module CheckProxies
  class Cli
    include Singleton
    
    PROXY_FILE = "#{ENV['HOME']}/.proxy.conf"
    
    private
    def check_url( proxy_uri, url )
      
      Net::HTTP::Proxy( proxy_uri.host, proxy_uri.port ).start( url ) do |http|
        
        case http.get 
          when Net::HTTPSuccess:
          when Net::HTTPRedirection: 
          when Net::HTTPClientError: 
          when Net::HTTPServerError: 
          when Net::HTTPInformation:
            return true 
        else
          return false
        end
      end
    rescue Exception => e
      Logger::instance.log.error e.message                            
      return false 
    end
    
    def save_proxy( proxy )
      
      File.open( PROXY_FILE, 'w' ) { |out| out.write( "export HTTP_PROXY='#{proxy}'" ) }
    rescue Exception => e
      Logger::instance.log.error e.message
    end
    
    def get_uri( proxy )
      URI.parse( "http://#{proxy}" )
    rescue Exception => e
      Logger::instance.log.error e.message
    end
    
    
    public
    def execute
   
      url     = Config::instance[:url]
      proxies = FasterCSV.read( File.join( ROOT_APP, Config::instance[:proxies_file] ) )
      
      proxies.each do |proxy|

        pu = get_uri( proxy )         
        Logger::instance.log.debug( "Checking proxy: #{pu}" )

        unless check_url( pu, url )
          Logger::instance.log.debug( "URL: #{pu} error" )
        else
          Logger::instance.log.info( "URL: #{pu} ok" )
          save_proxy( pu )
          break
        end
      end
    end
  end
end