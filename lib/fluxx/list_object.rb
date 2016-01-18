module Fluxx
  class ListObject < FluxxObject
    include Enumerable
    include ApiOperations::List
    include ApiOperations::Create

    def self.construct_from(values, opts = {})
      values = Util.symbolize_names(values)
      new.initialize_from values, opts
    end

    def initialize(*args)
      super
      @opts = {}
    end

    def first
      self.data.first
    end

    def last
      self.data.first
    end

    def each(&blk)
      self.data.each(&blk)
    end

    def empty?
      self.data.empty?
    end
  end
end