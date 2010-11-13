require 'yaml'
require 'singleton'


module CheckProxies
  class Config
    include Singleton

    def initialize()
      @config = File.open( Choice.choices[:config] ) { |file| YAML.load( file ) }
    end
    
    def []( key )
      @config[key] 
    end  
  end
end