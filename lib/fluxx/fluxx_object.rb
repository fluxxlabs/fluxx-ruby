module Fluxx
  class FluxxObject
    include Enumerable

    @@permanent_attributes = Set.new([:id])

    class << self
      attr_accessor :model_type
    end

    attr_accessor :model_type

    def initialize(try_id = nil, opts = {})
      reset try_id, opts
    end

    def reset(try_id = nil, opts = {})
      @model_type = self.class.model_type
      try_id, @retrieve_params = Util.normalize_id(try_id)
      @opts = opts
      @values = {}
      @values[:id] = try_id if try_id
      @unsaved_values = Set.new
      @transient_values = Set.new
      self
    end

    def assign_attributes(values, opts = {})
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
      values = Util.normalize_relations(values)
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

      assign_attributes(values, opts)
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
