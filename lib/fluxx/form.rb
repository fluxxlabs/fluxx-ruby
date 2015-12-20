module Fluxx
  class Form < ApiResource
    def self.get_data(data)
      data['records']['form'].first
    end

    def self.url
      "#{url_base}/form"
    end
  end
end
