module CheckProxies
  class Cli
    include Singleton
    
    DEFAULT_PROXY_CONFIG_FILE = "#{ENV['HOME']}/.proxy.conf"
    
    def save_proxy_configuration()
      File.open( File.join( ENV['HOME'], Config::instance[:proxy_config_file] ), 'w' ) { |out| out.write( "#{proxy}" ) }
    rescue Exception => e
      Logger::instance.error e.message
    end
    
    def execute( proxies_file, url )
   
      FasterCSV.read( proxies_file ).each do |proxy|
        
        unless URLChecker.new( proxy, url ).check
          Logger::instance.error( "URL: #{proxy} error" )
        else
          Logger::instance.info( "URL: #{proxy} ok" )
          save_proxy_configuration
          break
        end
      end    
    rescue Exception => e
      Logger::instance.error e.message          
    end
  end
end