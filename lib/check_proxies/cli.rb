require 'singleton'
require 'net/http'


module CheckProxies
  class Cli
    include Singleton
    
    def self.save_proxy_configuration( proxy )
      
      File.open( File.join( ENV['HOME'], Config::instance[:proxy_config_file] ), 'w' ) { |out| out.write( "#{proxy.host}:#{proxy.port}" ) }
    rescue Exception => e
      Logger::instance.error e.message
    end
        
    def self.save_proxy_list_status( proxies_file, proxy_list )
      
      File.open( proxies_file, 'w' ) { |f| f.write( proxy_list.to_yaml ) }
    end
    
    def run( proxies_file, url )

      proxies = YAML.load_file( proxies_file )
      
      proxies.each do |p|
      
        unless( p[:checked] )
          
          response = nil
          
          begin
            response = URLChecker.check( p[:url], url )
          rescue Exception => e
            Logger.instance.warn( e.message )
          end
          
          Logger.instance.debug( response ) unless response.nil?

          if( Net::HTTPSuccess != response )
            p[:checked] = true
          else
            Cli.save_proxy_configuration( proxy )            
            p[:checked] = true  
            break
          end
        end
      end
    rescue Exception => e
      Logger::instance.error( e.message )
    ensure
      Cli.save_proxy_list_status( proxies_file, proxies )            
    end
  end
end