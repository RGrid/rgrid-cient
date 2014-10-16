require 'httparty'
require 'logger'
module Retentiongrid

  # The Api class handles all calls to the Retentiongrid API.
  #
  class Api
    include HTTParty

    # Test
    # base_uri 'http://retentiongrid.apiary-mock.com'

    # Production
    base_uri 'https://app.retentiongrid.com/api'
    headers 'Content-type' => 'application/json'
    logger  ::Logger.new("log/httparty.log"), :debug, :curl


    class << self

      # Set your API key to communicate with retentiongrid
      # @param [String] api_key your API key,
      def api_key=(api_key)
        default_params token: api_key
      end

      # Do a HTTP GET requests with the given arguments
      # and then check for the response code.
      # @raise [Retentiongrid::BadRequest] (400) in case the request was not legible to the server
      # @raise [Retentiongrid::Forbidden] (403) access denied (e.g. wrong api key)
      # @raise [Retentiongrid::NotFound] (404) in case the requested resource could not be found
      # @raise [Retentiongrid::ServerError] (500) in case something went wrong on the retentiongrid server
      # @return [Httparty::Response]
      def get_with_response_check(*args)
        check_response_codes(get_without_response_check(*args))
      end
      alias_method :get_without_response_check, :get
      alias_method :get, :get_with_response_check

      # Do a HTTP POST requests with the given arguments
      # and then check for the response code.
      # @raise [Retentiongrid::BadRequest] (400) in case the request was not legible to the server
      # @raise [Retentiongrid::Forbidden] (403) access denied (e.g. wrong api key)
      # @raise [Retentiongrid::NotFound] (404) in case the requested resource could not be found
      # @raise [Retentiongrid::ServerError] (500) in case something went wrong on the retentiongrid server
      # @return [Httparty::Response]
      def post_with_response_check(*args)
        check_response_codes(post_without_response_check(*args))
      end
      alias_method :post_without_response_check, :post
      alias_method :post, :post_with_response_check

      # Do a HTTP DELETE requests with the given arguments
      # and then check for the response code.
      # @raise [Retentiongrid::BadRequest] (400) in case the request was not legible to the server
      # @raise [Retentiongrid::Forbidden] (403) access denied (e.g. wrong api key)
      # @raise [Retentiongrid::NotFound] (404) in case the requested resource could not be found
      # @raise [Retentiongrid::ServerError] (500) in case something went wrong on the retentiongrid server
      # @return [Httparty::Response]
      def delete_with_response_check(*args)
        check_response_codes(delete_without_response_check(*args))
      end
      alias_method :delete_without_response_check, :delete
      alias_method :delete, :delete_with_response_check

    end

    private

    def self.check_response_codes(response)
      body = response.body
      case response.code.to_i
      when 200..299 then return response
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