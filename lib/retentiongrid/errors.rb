module Retentiongrid

  # This error occurs when the request send to the server could not be parsed.
  class ParseError < HTTParty::Error; end

  # An object was not found in the database.
  class NotFound < HTTParty::Error; end

  # The API returned HTTP 400 (Bad Request).
  class BadRequest < HTTParty::Error; end # 400

  # The API operation wasn't authorized. This happens if you didn't set the user and
  # password for a write operation.
  class Unauthorized < HTTParty::Error; end # 401

  # You don't have sufficient permissions to make that request.
  class Forbidden < HTTParty::Error; end # 403

  # The object was not found (HTTP 404). Generally means that the object doesn't exist
  # and never has.
  class NotFound < HTTParty::Error; end # 404

  # If the request is not a HTTP PUT request
  class MethodNotAllowed < HTTParty::Error; end # 405

  # The object was not found (HTTP 410), but it used to exist. This generally means
  # that the object existed at some point, but was deleted.
  class Gone < HTTParty::Error; end # 410

  # Unspecified API server error.
  class ServerError < HTTParty::Error; end # 500

  # When the API service times out or returns an HTTP 503 status.
  class Unavailable < HTTParty::Error; end # 503

  # This method is not implemented yet.
  class NotImplemented < HTTParty::Error; end

end