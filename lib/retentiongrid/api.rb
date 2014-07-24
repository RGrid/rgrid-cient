require 'httparty'
require 'logger'
module Retentiongrid

  # The Api class handles all calls to the Retentiongrid API.
  #
  # Usage:
  #   require 'retentiongrid'
  #   api = Retentiongrid::Api.new
  #   @order = api.order(1234)
  class Api
    include HTTParty

    # base_uri 'https://app.retentiongrid.com/api'
    base_uri 'http://retentiongrid.apiary-mock.com'
    logger  ::Logger.new("log/httparty.log"), :debug, :curl

    def initialize(api_key)
      self.class.default_params token: api_key
    end

    # query params that filter the posts are:
    #   id (required). Filter by this id.
    def order(id, options={})
      self.class.get("/orders/#{id}")
    end
  end
end