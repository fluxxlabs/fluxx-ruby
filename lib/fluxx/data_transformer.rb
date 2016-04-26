module Fluxx
  class DataTransformer
    class << self
      def transform(key, value)
        return unless value

        case key
        when /_at$/
          DateTime.parse(value)
        else
          value
        end
      end
    end
  end
end