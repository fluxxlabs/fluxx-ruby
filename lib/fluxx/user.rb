require 'pry'
module Fluxx
  class User < ApiResource
    def self.get_data(data)
      data['records']['user'].first
    end

    def self.url
      "#{url_base}/user"
    end
  end
end
