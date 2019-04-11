module API
  module Auth
    class AuthorizeRequest
      private

      attr_reader :headers

      public

      def initialize(headers = {})
        @headers = headers
      end

      def call
        { user: user }
      end

      private

      def user
        # check if user is in the database
        # memoize user object
        @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
        # handle user not found
      rescue ActiveRecord::RecordNotFound => e
        # raise custom error
        raise(
          Errors::InvalidToken,
          ("#{Message.invalid_token} #{e.message}")
        )
      end

      def decoded_auth_token
        @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
      end

      # check for token in `Authorization` header
      def http_auth_header
        if headers['Authorization'].present?
          return headers['Authorization'].split(' ').last
        end
          raise(Errors::MissingToken, Message.missing_token)
      end
    end
  end
end
