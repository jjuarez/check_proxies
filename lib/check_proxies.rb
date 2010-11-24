%w[
  options_parser
  config
  logger
  url_checker
  cli
].each { |lib| require "check_proxies/#{lib}" }