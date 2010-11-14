Choice.options do
  header ''
  header '  Specific options:'

  option :config do
    short '-c'
    long  '--config=settings.yml'
    desc  'The yaml config file'
    default '../config/settings.yml'
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