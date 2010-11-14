module CheckProxies
  class Cli
    include Singleton
    
    DEFAULT_PROXY_CONFIG_FILE = "#{ENV['HOME']}/.proxy.conf"
    
    def execute( proxies_file, url )
   
      FasterCSV.read( proxies_file ).each do |proxy|
        
        unless URLChecker.new( proxy, url ).check
          Logger::instance.error( "URL: #{proxy} error" )
        else
          Logger::instance.info( "URL: #{proxy} ok" )
          File.open( DEFAULT_PROXY_CONFIG_FILE, 'w' ) { |out| out.write( "export HTTP_PROXY=#{proxy}" ) }
          break
        end
      end    
    rescue => e
      Logger::instance.error e.message          
    end
  end
end