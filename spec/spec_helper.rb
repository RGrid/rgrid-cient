require 'webmock/rspec'
require 'factory_girl'
require 'retentiongrid'
require 'shoulda/matchers'

require 'rspec'
require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|

  config.mock_with :rspec
  config.include FactoryGirl::Syntax::Methods
end

FactoryGirl.find_definitions

# HTTP requests are disabled, but make sure the mocking url is being used in test mode
Retentiongrid::Api::base_uri 'http://retentiongrid.apiary-mock.com'