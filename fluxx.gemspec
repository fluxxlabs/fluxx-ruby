Gem::Specification.new do |s|
  s.name        = 'fluxx-ruby'
  s.version     = '0.0.1'
  s.date        = '2015-12-19'
  s.summary     = "Fluxx Grant Management API wrapper gem"
  s.description = "A simple wrapper around the core Fluxx Grants API"
  s.authors     = ["Michael Yagudaev", "Alex Naser"]
  s.email       = 'michael@yagudaev.com'
  s.files       = ["lib/fluxx.rb"]
  s.homepage    =
    'http://rubygems.org/gems/fluxx'
  s.license     = 'MIT'


  s.add_dependency('rest-client', '~> 1.8')
  s.add_dependency('activesupport', '~> 4.2', '>= 4.2.5')

  s.add_development_dependency('rspec', '~> 3.4')
  s.add_development_dependency('vcr', '~> 3.0')
  s.add_development_dependency('webmock', '~> 1.22')
end
