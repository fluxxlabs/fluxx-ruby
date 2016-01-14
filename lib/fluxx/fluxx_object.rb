module Fluxx
  class FluxxObject
    def initialize_from(hash)
      @values = hash
    end

    def to_json
      @values.to_json
    end

    def as_json
      @values.as_json
    end

  private
    def method_missing(name, *args)
      name = name.to_s
      if name.end_with?('=')
        @values[name] = args
      else
        @values[name] if @values.has_key?(name)
      end
    end
  end
end
