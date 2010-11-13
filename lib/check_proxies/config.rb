require 'yaml'
require 'singleton'


module CheckProxies
  class Config
    include Singleton

    def initialize()
      @config = File.open( Choice.choices[:config] ) { YAML.load( f ) }
    end
    
    def []( key )
      @config[key] 
    end  
  end
end