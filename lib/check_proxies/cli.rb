require 'uri'
require 'net/http'
require 'faster_csv'
require 'singleton'


module CheckProxies
  class Cli
    include Singleton
    
    DEFAULT_PROXY_FILE = "ENV['HOME']/.proxy.conf"
    
    private
    def check_url( proxy_uri, url )
      Net::HTTP::Proxy( proxy_uri.host, proxy_uri.port ).start( url ) { |http| return http.get == Net::HTTPSuccess }
    rescue Exception => e
      Logger::instance.error( e )                            
      return false 
    end
    
    def save_proxy( proxy_uri )
      File.open( DEFAULT_PROXY_FILE, 'w' ) { |out| out.write( "export HTTP_PROXY='#{proxy_uri}'" ) }
    rescue Exception => e
      Logger::instance.error( e )                            
    end
    
    def get_uri( proxy_info )
      URI.parse( "http://#{proxy}" )
    rescue Exception => e
      Logger::instance.error( e )
    end
    
    public
    def execute
   
      url     = Config::instance[:url]
      proxies = FasterCSV.read( File.join( File.dirname( __FILE__ ), '..', Config::instance[:proxies_file] ) )
      pindex  = 0
      
      proxies.each do |proxy|

        proxy_uri = get_uri( proxy )
        
        Logger::instance.debug( "Checking proxy: #{proxy_uri}" )
        
        if check_url( proxy_uri, url )
          Logger::instance.info( "URL: #{proxy_uri} ok" )
          save_proxy( proxy_uri )
          break
        else
          Logger::instance.debug( "URL: #{proxy_uri} error" )
        end
        
        pindex+=1
      end
    end
  end
end