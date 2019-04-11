module Api
  module Auth
    module Errors
      class AuthenticationError < StandardError; end
      class MissingToken < StandardError; end
      class InvalidToken < StandardError; end
      class ExpiredSignature < StandardError; end
    end
  end
end
