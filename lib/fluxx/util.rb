module Fluxx
  module Util

    def self.normalize_id(id)
      if id.kind_of?(Hash)
        params_hash = id.dup
        id = params_hash.delete(:id)
      else
        params_hash = {}
      end
      [id, params_hash]
    end

    def self.symbolize_names(object)
      case object
      when Hash
        new_hash = {}
        object.each do |key, value|
          new_hash[key.to_sym] = symbolize_names(value)
        end
        new_hash
      when Array
        object.map { |value| symbolize_names(value) }
      else
        object
      end
    end

    def self.convert_to_fluxx_object(resp, opts, model_type)
      case resp
      when Array
        resp.map { |i| convert_to_fluxx_object(i, opts, model_type) }
      when Hash
        ApiResource.of_model_type(model_type).construct_from(resp, opts)
      else
        resp
      end
    end

  end
end