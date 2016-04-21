module Fluxx
  class ListObject < FluxxObject
    extend Forwardable
    
    include Enumerable
    include ApiOperations::List
    include ApiOperations::Request
    include ApiOperations::Create

    DATA_METHODS = [:first, :last, :count, :size, :length, :each, :select, :map, :empty?]

    class << self

      def construct_from(model_type, values, opts = {})
        values = Util.symbolize_names(values)
        opts   = Util.symbolize_names(opts)
        Fluxx.model_class(model_type, :ListObject).new.initialize_from values, opts
      end

      def empty_list(opts = {})
        construct_from(@model_type, { data: [] }, opts)
      end

    end

    def auto_paging_each(&block)
      return enum_for(:auto_paging_each) unless block_given?

      page = self
      loop do
        page.each(&block)
        page = page.next_page
        break if page.empty?
      end
    end

    def_delegators :data, *DATA_METHODS

    def to_a
      self.data
    end

    def next_page
      return self.class.empty_list(@opts) if !has_more?

      @opts.merge!(page: (@opts[:current_page] + 1))
      list @opts
    end

    protected

    def has_more?
      @opts[:total_pages] > @opts[:current_page]
    end

  end
end
