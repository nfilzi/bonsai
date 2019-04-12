module RequestSpecHelper
  def json_response
    JSON.parse(response.body)
  end

  def api_headers(version: 1)
    { "Accept" => "application/json;version=#{version}" }
  end
end
