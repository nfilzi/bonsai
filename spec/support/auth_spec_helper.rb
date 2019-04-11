require 'json_web_token'

module AuthSpecHelper
  # generate tokens from user id
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  # generate expired tokens from user id
  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  def valid_headers(user, version: 1)
    {
      "Authorization" => token_generator(user.id),
      "Accept"        => "application/json;version=#{version}"
    }
  end

  def invalid_headers(user, version: 1)
    {
      "Authorization" => nil,
      "Accept"        => "application/json;version=#{version}"
    }
  end
end
