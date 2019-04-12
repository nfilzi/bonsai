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

  def valid_headers(user)
    {
      "Authorization" => token_generator(user.id),
    }.merge(api_headers)
  end

  def invalid_headers(user)
    {
      "Authorization" => nil,
    }.merge(api_headers)
  end
end
