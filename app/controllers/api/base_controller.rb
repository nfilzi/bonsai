module API
  class BaseController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActiveRecord::RecordInvalid,  with: :render_422

    rescue_from Auth::Errors::AuthenticationError, with: :render_401
    rescue_from Auth::Errors::MissingToken,        with: :render_422
    rescue_from Auth::Errors::InvalidToken,        with: :render_422
    rescue_from Auth::Errors::ExpiredSignature,    with: :render_422

    before_action :authorize_request
    attr_reader :current_user

    private

    def authorize_request
      @current_user = (Auth::AuthorizeRequest.new(request.headers).call)[:user]
    end

    def json_response(object, status = :ok)
      render json: object, status: status
    end

    def render_404(e)
      json_response({ message: e.message }, :not_found)
    end

    def render_422(e)
      json_response({ message: e.message }, :unprocessable_entity)
    end

    def render_401(e)
      json_response({ message: e.message }, :unauthorized)
    end
  end
end
