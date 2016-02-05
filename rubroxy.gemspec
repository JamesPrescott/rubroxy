Gem::Specification.new do |s|
  s.name = 'rubroxy'
  s.version = '0.0.0'
  s.date = '2016-01-29'
  s.license = 'GPL-3.0'

  s.summary = 'Rubroxy'
  s.description = 'A simple ruby built proxy'
  s.authors = ['James Prescott']
  s.email = 'jamesprescott1987@gmail.com'
  s.homepage = 'https://github.com/JamesPrescott/rubroxy'
  s.files = ['lib/rubroxy.rb',
             'lib/rubroxy/proxy_core.rb']

  s.add_runtime_dependency 'webrick', '~> 1.3', '>= 1.3.1'
  s.add_runtime_dependency 'logger', '~> 1.2', '>= 1.2.8'
  s.add_development_dependency 'rspec', '~> 3.4', '>= 3.4.0'
  s.add_development_dependency 'httparty', '~> 0.13', '>= 0.13.7'
end
