lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubroxy/version'

Gem::Specification.new do |s|
  s.name = 'rubroxy'
  s.version = Rubroxy::VERSION
  s.date = '2016-01-29'
  s.license = 'GPL-3.0'

  s.summary = 'Rubroxy'
  s.description = 'A simple ruby built proxy'
  s.authors = ['James Prescott']
  s.email = 'james.prescott@itv.com'
  s.homepage = 'https://github.com/ITV/rubroxy'
  s.files = Dir.glob('{bin,lib}/**/*') + %w(LICENSE README.md)
  s.require_path = ['lib']

  s.add_runtime_dependency 'webrick', '~> 1.3', '>= 1.3.1'
  s.add_runtime_dependency 'logger', '~> 1.2', '>= 1.2.8'
  s.add_development_dependency 'rspec', '~> 3.4', '>= 3.4.0'
end
