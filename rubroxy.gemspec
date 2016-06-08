lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubroxy/version'

Gem::Specification.new do |s|
  s.name = 'rubroxy'
  s.version = Rubroxy::VERSION
  s.date = '2016-06-08'
  s.license = 'ITVPL'

  s.summary = 'Rubroxy'
  s.description = 'A simple ruby built proxy'
  s.authors = ['James Prescott']
  s.email = 'james.prescott@itv.com'
  s.homepage = 'https://github.com/ITV/rubroxy'
  s.files = Dir.glob('{bin,lib}/**/*') + %w(LICENSE.md README.md)
  s.cert_chain = ['certs/tibolight.pem']
  s.signing_key = File.expand_path('~/.ssh/gem-private_key.pem') if $0 =~ /gem\z/
  s.require_path = ['lib']

  s.add_runtime_dependency 'webrick', '~> 1.3', '>= 1.3.1'
  s.add_runtime_dependency 'logger', '~> 1.2', '>= 1.2.8'
  s.add_development_dependency 'rspec', '~> 3.4', '>= 3.4.0'
end
