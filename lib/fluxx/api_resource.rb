module Fluxx
  class ApiResource < FluxxObject
    include ApiOperations::Request
    extend ApiOperations::List
    extend ApiOperations::Fetch
    extend ApiOperations::Create
    include ApiOperations::Update
    include ApiOperations::Destroy

    DEFAULTS = {
      association_style: "full"
    }.freeze

    class << self

      def construct_from(model_type, values, opts = {})
        values = Util.symbolize_names(values)
        Fluxx.model_class(model_type, :ApiResource).new(values[:id]).initialize_from values, opts
      end

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

          update_hash
        else
          obj
        end
      end
    end

    def id
      @values[:id]
    end

    def reset_from(values, opts = {})
      values = Util.symbolize_names(values)
      reset(values[:id]).initialize_from values, opts
    end

    def unsaved_hash
      self.class.serialize_params(self)
    end

    def method_missing(symbol, *args)
      association(symbol)
    end

    protected

    def association(association_name)
      opts = { relation: { association_name => DEFAULTS[:association_style] }}
      response = request :fetch, model_id: @values[:id], options: opts

      association_model_type = association_name.to_s.singularize      
      records = response[@model_type] && response[@model_type][association_name.to_s]
      raise(FluxxError, "Cannot find association #{association_name}") unless records.is_a?(Array)

      # the API returns an array even for intentionally singular associations
      # account for that!
      if (association_name.to_s == association_name.to_s.singularize)
        ApiResource.construct_from(association_model_type, records.first, {}) if records.first
      else
        ListObject.construct_from(association_model_type, { data: records }, {})
      end
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
