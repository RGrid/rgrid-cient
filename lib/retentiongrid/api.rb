require 'httparty'
require 'logger'
module Retentiongrid

  # The Api class handles all calls to the Retentiongrid API.
  #
  # Usage:
  #   require 'retentiongrid'
  #   Retentiongrid::Api.api_key = "your_api_key"
  #   order = Retentiongrid::Order.find(1234)
  class Api
    include HTTParty

    base_uri 'https://app.retentiongrid.com/api'
    logger  ::Logger.new("log/httparty.log"), :debug, :curl


    class << self

      def api_key=(api_key)
        default_params token: api_key
      end

      def get_with_response_check(path, options={}, &block)
        check_response_codes(get_without_response_check(path, options={}, &block))
      end
      alias_method_chain :get, :response_check

      def post_with_response_check(path, options={}, &block)
        check_response_codes(post_without_response_check(path, options={}, &block))
      end
      alias_method_chain :post, :response_check

    end

    private

    def self.check_response_codes(response)
      body = response.body
      case response.code.to_i
      when 200 then return response
      when 400 then raise BadRequest.new(body)
      when 401 then raise Unauthorized.new(body)
      when 403 then raise Forbidden.new(body)
      when 404 then raise NotFound.new(body)
      when 405 then raise MethodNotAllowed.new(body)
      when 410 then raise Gone.new(body)
      when 422 then raise UnprocessableEntity.new(body)
      when 500 then raise ServerError, 'Internal Server Error'
      when 503 then raise Unavailable, 'Service Unavailable'
      else raise "Unknown response code: #{response.code}"
      end
    end


  end
end