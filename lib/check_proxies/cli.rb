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
      
      proxy = Net::HTTP::Proxy( proxy_uri.host, proxy_uri.port )
      
      proxy.start( url ) do |http|
        
        request  = Net::HTTP::Get.new( "/" )
        response = http.request( request )
        
        Logger::instance.log.debug( response.inspect )
        return( response == Net::HTTPSucess )
      end
    rescue => e
      Logger::instance.log.error e.message                            
      return false 
    end
    
    
    def save_proxy( proxy )
      
      File.open( PROXY_FILE, 'w' ) do |out| 
        out.write( "##" )
        out.write( "# Fichero generado automaticamente NO modificar" )
        out.write( "export HTTP_PROXY=#{proxy}" ) 
      end
    rescue Exception => e
      Logger::instance.log.error e.message
    end
    
    
    def get_uri( proxy )
    
      URI.parse( proxy )
    rescue URI::InvalidURIError => e
      Logger::instance.log.error e.message
      nil
    end
    
    
    public
    def execute
   
      url     = Config::instance[:url]
      proxies = FasterCSV.read( File.join( ROOT_APP, Config::instance[:proxies_file] ) )
      
      proxies.each do |p|

        pu = get_uri( "http://#{p}" ) 
        
        unless( pu.nil? )       
          unless check_url( pu, url )
            Logger::instance.log.error( "URL: #{pu} error" )
          else
            Logger::instance.log.info( "URL: #{pu} ok" )
            save_proxy( pu )
            break
          end
        end
      end
    end
  end
end