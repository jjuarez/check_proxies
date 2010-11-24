require 'singleton'
require 'yaml'


module CheckProxies
  
  class YAMLFileNotFound < StandardError; end
  
  class Config
    include Singleton

    def initialize
      @config = YAML.load_file( Choice.choices[:config] )
    rescue => e
      Logger.instance.error( e.message )
      raise YAMLFileNotFound.new( e.message )
    end
    
    def []( key )
      @config[key.to_sym] unless @config.nil?
    end
  end
end