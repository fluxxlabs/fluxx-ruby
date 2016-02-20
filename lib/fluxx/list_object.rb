module Fluxx
  class ListObject < FluxxObject
    include Enumerable
    include ApiOperations::List
    include ApiOperations::Request
    include ApiOperations::Create

    class << self
      def construct_from(model_type, values, opts = {})
        values = Util.symbolize_names(values)
        opts   = Util.symbolize_names(opts)
        of_model_type(model_type).new.initialize_from values, opts
      end

      def empty_list(opts = {})
        construct_from(@model_type, { data: [] }, opts)
      end
    end

    def next_page
      return self.class.empty_list(@opts) if !has_more?

      list(page: @opts[:current_page] + 1)
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

    def has_more?
      @opts[:total_pages]
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