# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name = 'proof'
  s.summary = 'Proof Library'
  s.version = '0.0.1'
  s.authors = ['The Sans Collective']
  s.homepage = 'https://github.com/Sans/proof'
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.2'
  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')

  s.add_dependency 'logging'
end

