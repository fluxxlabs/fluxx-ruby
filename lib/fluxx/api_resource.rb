module Fluxx
  class ApiResource < FluxxObject
    include ApiOperations::Request
    extend ApiOperations::List
    extend ApiOperations::Fetch
    extend ApiOperations::Create
    include ApiOperations::Update
    include ApiOperations::Destroy

    DEFAULTS = {
      association_style: "compact"
    }.freeze

    class << self
      attr_accessor :model_type

      def load(args)
        values, opts = Marshal.load(args)
        construct_from(@model_type, values, opts)
      end

      def serialize_params(obj, original_value = nil)
        case obj
        when nil
          ''
        when Array
          update = obj.map { |v| serialize_params(v) }
          if original_value != update
            update
          else
            nil
          end
        when FluxxObject
          unsaved_keys = obj.instance_variable_get(:@unsaved_values)
          obj_values = obj.instance_variable_get(:@values)
          update_hash = {}

          unsaved_keys.each do |k|
            update_hash[k] = serialize_params(obj_values[k])
          end

          obj_values.each do |k, v|
            if v.is_a?(Array)
              original_value = obj.instance_variable_get(:@original_values)[k]

              # the conditional here tests whether the old and new values are
              # different (and therefore needs an update), or the same (meaning
              # we can leave it out of the request)
              if updated = serialize_params(v, original_value)
                update_hash[k] = updated
              else
                update_hash.delete(k)
              end
            elsif v.is_a?(FluxxObject) || v.is_a?(Hash)
              update_hash[k] = obj.serialize_nested_object(k)
            end
          end

          update_hash
        else
          obj
        end
      end
    end

    def id
      @values[:id]
    end

    def method_missing(symbol, *args)
      association(symbol)
    end

    def association(association_name)
      opts = { relation: { association_name => DEFAULTS[:association_style] }}
      response = request :fetch, model_type: @model_type, model_id: @values[:id], options: opts

      association_model_type = association_name.to_s.singularize
      records = response[@model_type][association_name.to_s]
      ListObject.construct_from(association_model_type, { data: records }, {}) if records.is_a?(Array)
    end

    def serialize_nested_object(key)
      new_value = @values[key]
      if new_value.is_a?(ApiResource)
        return {}
      end

      if @unsaved_values.include?(key)
        update = new_value
        new_keys = update.keys.map(&:to_sym)

        if @original_values[key]
          keys_to_unset = @original_values[key].keys - new_keys
          keys_to_unset.each {|key| update[key] = ''}
        end

        update
      else
        self.class.serialize_params(new_value)
      end
    end

  end
end
