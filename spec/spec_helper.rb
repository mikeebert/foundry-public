$: << File.expand_path(File.dirname(__FILE__)) + '/../'
$: << File.expand_path(File.dirname(__FILE__)) + '/../lib/datastore/memory_datastore'

require 'foundry'
require 'environment'

require 'sinatra'
require 'rack/test'

set :environment, :test

def app
  Sinatra::Application
end

#makes Rake::Test available to all contexts
RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Warden::Test::Helpers
end

