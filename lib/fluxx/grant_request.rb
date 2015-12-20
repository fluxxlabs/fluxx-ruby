module Fluxx
  class GrantRequest < ApiResource
    def self.get_data(data)
      data['records']['grant_request'].first
    end

    def self.url
      "#{url_base}/grant_request"
    end
  end
end
