# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name = 'proof'
  s.summary = 'Proof Library'
  s.version = '0.0.0'
  s.authors = 'We made this'
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.2'
  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')

  s.add_development_dependency 'rspec'
end

