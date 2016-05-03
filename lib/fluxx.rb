# deps
require 'rest-client'
require 'active_support/inflector'
require 'drb/drb'
require 'forwardable'

# fluxx
require 'fluxx/configuration'
require 'fluxx/util'
require 'fluxx/data_transformer'

require 'fluxx/api_operations/request'
require 'fluxx/api_operations/list'
require 'fluxx/api_operations/fetch'
require 'fluxx/api_operations/create'
require 'fluxx/api_operations/update'
require 'fluxx/api_operations/destroy'

require 'fluxx/protocols/http'
require 'fluxx/protocols/druby'

require 'fluxx/fluxx_object'
require 'fluxx/list_object'
require 'fluxx/api_resource'

require 'fluxx/errors/fluxx_error'
require 'fluxx/errors/fluxx_configuration_error'
require 'fluxx/errors/fluxx_method_missing_error'

module Fluxx

  include Configuration

  class << self
    def const_missing(name)
      model_class name
    end

    def model_class(name, klass_to_inherit = :ApiResource)
      # like Fluxx::UserApiResource or Fluxx::UserListObject
      klass_name = "#{name.to_s.camelize}#{klass_to_inherit.to_s}"

      # if already defined
      if Fluxx.constants.include?(klass_name.to_sym) 
        Fluxx.const_get(klass_name)
      else
        klass = Fluxx.const_set klass_name.to_sym, Class.new(Fluxx.const_get(klass_to_inherit))
        klass.model_type = name.to_s.underscore
        klass
      end
    end
  end

end
