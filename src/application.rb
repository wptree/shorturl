require 'sinatra'
require "redis"
require "json"
require 'digest'
require 'yaml'

URL_AUTO_CREMENTAL_KEY = 'url_unique_integer_identifier'

config = begin
  root =  File.dirname(__FILE__)
  YAML.load(File.open(root << File::SEPARATOR << 'config.yml'))
rescue ArgumentError => e
  puts "Could not parse configuration YAML: #{e.message}"
end

redis = Redis.new(:host => config['redis_host'], :port => config['redis_port'])
short_url_prefix = config['short_url_prefix']


%w{controllers lib}.each do |dir|
  Dir.glob(File.expand_path("../#{dir}", __FILE__) + '/**/*.rb').each do |file|
    require file
  end
end
