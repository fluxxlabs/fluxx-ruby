Gem::Specification.new do |s|
  s.name        = 'fluxx'
  s.version     = '0.0.4'
  s.date        = '2016-03-21'
  s.summary     = "Fluxx Grant Management API wrapper gem"
  s.description = "A simple wrapper around the core Fluxx Grants API"
  s.authors     = ["Michael Yagudaev", "Alex Naser"]
  s.email       = 'alex@functionalimperative.com'
  s.files       =  Dir['lib/**/*.rb']
  s.homepage    = 'https://github.com/fluxxlabs/fluxx-ruby'
  s.license     = 'MIT'


  s.add_dependency('rest-client', '>= 1.6.7')
  s.add_dependency('activesupport', '>= 3.2')

  s.add_development_dependency('byebug')
end
