module Api
  module Auth
    class AuthenticateUser
      private

      attr_reader :email, :password

      public

      def initialize(email, password)
        @email    = email
        @password = password
      end

      def call
        JsonWebToken.encode(user_id: user.id) if user
      end

      private

      def user
        user = User.find_by(email: email)
        return user if user && user.valid_password?(password)

        raise(Api::Auth::Errors::AuthenticationError, Message.invalid_credentials)
      end
    end
  end
end
