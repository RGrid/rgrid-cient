require 'webmock/rspec'
require 'factory_girl'
require 'retentiongrid'
require 'shoulda/matchers'

require 'rspec'

RSpec.configure do |config|

  config.mock_with :rspec
  config.include FactoryGirl::Syntax::Methods
end

FactoryGirl.find_definitions