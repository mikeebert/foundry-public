require File.join(File.expand_path(File.dirname(__FILE__)),'../../foundry')

require "Capybara"
require "Capybara/cucumber"
require "rspec"
  
World do
  Capybara.app = Foundry
  
  include Capybara::DSL
  include RSpec::Matchers
end
