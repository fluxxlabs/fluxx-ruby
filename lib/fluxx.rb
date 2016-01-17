# deps
require 'rest-client'
require 'active_support/inflector'
require 'drb/drb'

# fluxx
require 'fluxx/configuration'
require 'fluxx/util'

require 'fluxx/api_operations/request'
require 'fluxx/api_operations/list'
require 'fluxx/api_operations/fetch'
require 'fluxx/api_operations/create'
require 'fluxx/api_operations/update'
require 'fluxx/api_operations/delete'

require 'fluxx/protocols/http'
require 'fluxx/protocols/druby'

require 'fluxx/fluxx_object'
require 'fluxx/list_object'
require 'fluxx/api_resource'

require 'fluxx/errors/fluxx_error'

module Fluxx

  include Configuration

  class << self
    def const_missing(name)
      ApiResource.of_model_type name
    end
  end

end
