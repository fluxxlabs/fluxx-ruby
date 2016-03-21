Gem::Specification.new do |s|
  s.name        = 'fluxx'
  s.version     = '0.0.3'
  s.date        = '2016-03-21'
  s.summary     = "Fluxx Grant Management API wrapper gem"
  s.description = "A simple wrapper around the core Fluxx Grants API"
  s.authors     = ["Michael Yagudaev", "Alex Naser"]
  s.email       = 'michael@yagudaev.com'
  s.files       =  Dir['lib/*.rb']
  s.homepage    =
    'http://rubygems.org/gems/fluxx'
  s.license     = 'MIT'


  s.add_dependency('rest-client', '~> 1.8')
  s.add_dependency('activesupport', '~> 4.2', '>= 4.2.5')

  s.add_development_dependency('rspec', '~> 3.4')
  s.add_development_dependency('vcr', '~> 3.0')
  s.add_development_dependency('webmock', '~> 1.22')
  s.add_development_dependency('byebug')
end
