require 'httparty'
require 'logger'
module Retentiongrid

  # The Api class handles all calls to the Retentiongrid API.
  #
  # Usage:
  #   require 'retentiongrid'
  #   Retentiongrid::Api.api_key = "api_key"
  #   order = Retentiongrid::Order.find(1234)
  class Api
    include HTTParty

    base_uri 'https://app.retentiongrid.com/api'
    logger  ::Logger.new("log/httparty.log"), :debug, :curl

    def self.api_key=(api_key)
      default_params token: api_key
    end
  end
end