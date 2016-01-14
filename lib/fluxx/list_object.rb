module Fluxx
  class ListObject < FluxxObject
    include Enumerable
    include ApiOperations::List
    include ApiOperations::Create

    attr_accessor :filters

    def self.construct_from(values, opts = {})
      values = Util.symbolize_names(values)
      new.initialize_from values, opts
    end

    def initialize(*args)
      super
      self.filters = {}
    end

    def each(&blk)
      self.data.each(&blk)
    end

    def empty?
      self.data.empty?
    end
  end
end