require 'fluxx'
require 'rspec'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir     = 'spec/fixtures/vcr'
  c.hook_into                :webmock
  c.ignore_localhost         = true
  c.default_cassette_options = { :record => :none }
  c.configure_rspec_metadata!
  # TODO: temporary
  c.allow_http_connections_when_no_cassette = true
end
