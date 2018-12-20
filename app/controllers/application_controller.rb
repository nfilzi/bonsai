class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def render_json(content)
    render(
      json: {
        content: content,
        alert:   flash[:alert],
        notice:  flash[:notice]
      },
      status: (flash[:alert] ? :unprocessable_entity : :ok)
    )

    flash.clear
  end

  def render_partial(partial, locals = {})
    render_to_string partial: partial, locals: locals, formats: [:html]
  end
end
