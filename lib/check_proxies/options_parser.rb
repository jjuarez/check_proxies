require 'choice'


Choice.options do
  header ''
  header '  Specific options:'

  option :config do
    short '-c'
    long  '--config=settings.yml'
    desc  'The yaml config file'
    default '../config/settings.yml'
  end 
  
  option :application do
    short '-u'
    long  '--url=value'
    desc  'The URL to check'
  end

  separator ''
  separator '  Common options:'

  option :help do
    short '-h'
    long '--help'
    desc "Show this screen"
  end
  
  separator ''
end