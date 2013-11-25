# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'proof'
  s.summary = 'Proof Library'
  s.version = '0.0.6'
  s.authors = ['The Sans Collective']
  s.license = 'MIT'
  s.homepage = 'https://github.com/Sans/proof'
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.2'
  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')

  s.add_dependency 'output'
  s.add_dependency 'initializer'
  s.add_dependency 'setter'
  s.add_dependency 'single'
  s.add_dependency 'extension'
end
