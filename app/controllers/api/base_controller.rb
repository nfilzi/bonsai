module Api
  class BaseController < ActionController::API
    class AuthenticationError < StandardError; end
    class MissingToken < StandardError; end
    class InvalidToken < StandardError; end

    rescue_from ActiveRecord::RecordNotFound, with: :_404
    rescue_from ActiveRecord::RecordInvalid,  with: :_422

    rescue_from AuthenticationError, with: :_401
    rescue_from MissingToken,        with: :_422
    rescue_from InvalidToken,        with: :_422

    private

    def json_response(object, status = :ok)
      render json: object, status: status
    end

    def _404(e)
      json_response({ message: e.message }, :not_found)
    end

    def _422(e)
      json_response({ message: e.message }, :unprocessable_entity)
    end

    def _401(e)
      json_response({ message: e.message }, :unauthorized)
    end
  end
end
