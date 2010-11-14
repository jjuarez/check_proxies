module CheckProxies
  class Config
    include Singleton

    def initialize()
      @config = File.open( Choice.choices[:config] ) { |file| YAML.load( file ) }
    rescue => e
      Logger::instance.error e
      raise YAMLFileNotFound.new( e.message )
    end
    
    def []( key )
      @config[key] unless @config.nil?
    end
  end
end