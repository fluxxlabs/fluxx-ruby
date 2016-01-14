module Fluxx
  class ApiResource < FluxxObject
    def self.retrieve
      data = get(url)
      instance = self.new()
      parsed_data = get_data(JSON.parse(data))
      raise parsed_data if parsed_data['error']
      instance.initialize_from(parsed_data)
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
      # TODO: rest-client will need to add the base there
      Protocol.get url, { "Authorization" => "Bearer #{Fluxx.token}" }
    end

    def self.url_base
      "#{Fluxx.server_url}/api/rest/v1"
    end
  end
end
