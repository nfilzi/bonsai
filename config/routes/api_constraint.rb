module Routes
  class ApiConstraint
    REGEXP = /application\/json;version=(?<api_version_id>\d+)/

    def initialize(version:)
      @version = version
    end

    def matches?(request)
      accept_header = request.headers.fetch(:accept)

      accept_header.match(REGEXP)[:api_version_id].to_i == @version
    end
  end
end
