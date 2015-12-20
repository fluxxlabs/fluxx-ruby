module Fluxx
  class ApiResource < FluxxObject
    def self.retrieve
      data = get(url)
      instance = self.new()
      instance.initialize_from(get_data(JSON.parse(data)))
      instance
    end

    def self.get_data(data)
      raise "must define a get_data for resource. This is an abstract method"
    end

    def self.url
      raise "must define a url for resource. This is an abstract method"
    end

  private
    def self.get(url)
      RestClient.get url, { "Authorization" => "Bearer #{Fluxx.token}" }
    end

    def self.url_base
      "#{Fluxx.server_url}/api/rest/v1"
    end
  end
end
