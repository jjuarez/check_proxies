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
        
        if URLChecker.new( proxy, url ).check == Net::HTTPSuccess )
          Logger::instance.info( "URL: #{proxy} ok" )
          save_proxy_configuration

          break
        else
          Logger::instance.error( "URL: #{proxy} error" )
        end
      end    
    rescue Exception => e
      Logger::instance.error e.message          
    end
  end
end