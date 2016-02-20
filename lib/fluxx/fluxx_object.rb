module Fluxx
  class FluxxObject
    include Enumerable

    @@permanent_attributes = Set.new([:id])

    class << self

      attr_accessor :model_type

      def of_model_type(model_type)
        @model_type = model_type.to_s.underscore
        self
      end

      def construct_from(model_type, values, opts = {})
        values = Util.symbolize_names(values)
        of_model_type(model_type).new(values[:id]).initialize_from values, opts
      end

    end

    def initialize(id = nil, opts = {})
      @model_type = self.class.model_type
      id, @retrieve_params = Util.normalize_id(id)
      @opts = opts
      @values = {}
      @values[:id] = id if id
      @unsaved_values = Set.new
      @transient_values = Set.new
    end

    def update_attributes(values, opts = {})
      values.each do |k, v|
        @values[k] = Util.convert_to_fluxx_object(v, opts, @model_type)
        @unsaved_values.add(k)
      end
    end

    def to_json
      JSON.generate(@values)
    end

    def initialize_from(values, opts, partial=false)
      @opts = opts
      @original_values = Marshal.load(Marshal.dump(values))

      removed = partial ? Set.new : Set.new(@values.keys - values.keys)
      added = Set.new(values.keys - @values.keys)

      instance_eval do
        remove_accessors(removed)
        add_accessors(added, values)
      end

      removed.each do |k|
        @values.delete(k)
        @transient_values.add(k)
        @unsaved_values.delete(k)
      end

      update_attributes(values, opts)
      values.each do |k, _|
        @transient_values.delete(k)
        @unsaved_values.delete(k)
      end

      self
    end

    protected

    def metaclass
      class << self; self; end
    end

    def add_accessors(keys, values)
      metaclass.instance_eval do
        keys.each do |k|
          next if @@permanent_attributes.include?(k)
          k_eq = :"#{k}="
          define_method(k) { @values[k] }
          define_method(k_eq) do |v|
            @values[k] = v
            @unsaved_values.add(k)
          end

          if [FalseClass, TrueClass].include?(values[k].class)
            k_bool = :"#{k}?"
            define_method(k_bool) { @values[k] }
          end
        end
      end
    end

    def remove_accessors(keys)
      metaclass.instance_eval do
        keys.each do |k|
          next if @@permanent_attributes.include?(k)
          k_eq = :"#{k}="
          remove_method(k) if method_defined?(k)
          remove_method(k_eq) if method_defined?(k_eq)
        end
      end
    end
  end
end
