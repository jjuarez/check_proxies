$:.unshift( File.dirname( __FILE__ ))

# rubygem dependencies
%w[
  rubygems
  yaml
  uri
  logger
  singleton
  net/http
  fileutils
  choice
  faster_csv
  pony
].each { |gem| require gem }

# app dependencies
%w[
  options_parser
  exceptions
  config
  logger
  url_checker
  mailer
  cli
].each { |file| require "check_proxies/#{file}" }
