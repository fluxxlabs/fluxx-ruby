module Fluxx
  class FluxxObject
    def initialize_from(hash)
      @values = hash
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
