module Fluxx
  class ListObject < FluxxObject
    include Enumerable
    include ApiOperations::List
    include ApiOperations::Create

    class << self
      def construct_from(model_type, values, opts = {})
        values = Util.symbolize_names(values)
        of_model_type(model_type).new.initialize_from values, opts
      end
    end

    def initialize(*args)
      super
      @opts = {}
    end

    def first
      self.data.first
    end

    def last
      self.data.last
    end

    def each(&blk)
      self.data.each(&blk)
    end

    def empty?
      self.data.empty?
    end
  end
end