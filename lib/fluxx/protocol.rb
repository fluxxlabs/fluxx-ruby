module Fluxx
  class Protocol
    ApiService = DRbObject.new_with_uri('druby://localhost:8788')

    def self.get(url, headers)
      ApiService.index(model_type: url)
    end
  end
end
