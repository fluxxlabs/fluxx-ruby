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

    def self.normalize_relations(hash)
      new_hash = {}
      hash.each do |key, value|
        if value.is_a?(Array)
          # belongs_to association
          if key.to_s.singularize == key.to_s && value.count == 1
            new_hash["#{key}_id".to_sym] = value.first[:id] if value.first[:id]
          end

          # has_many association
          if key.to_s == 'data'
            new_hash[:data] = value
          end

          # else don't add hash
        else
          new_hash[key] = value
        end
      end

      new_hash
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
        ApiResource.construct_from(model_type, resp, opts)
      else
        resp
      end
    end

  end
end
