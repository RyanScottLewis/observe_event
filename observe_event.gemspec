# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'observe_event'

Gem::Specification.new do |spec|
  spec.name          = 'observe_event'
  spec.version       = ObserveEvent::VERSION
  spec.authors       = ['Ryan Scott Lewis']
  spec.email         = ['ryanscottlewis@gmail.com']
  spec.homepage      = 'https://github.com/RyanScottLewis/observe_event'
  spec.license       = 'MIT'

  spec.summary       = 'Small and effective implementation of the observer pattern to define event methods on objects.'
  spec.description   = <<~DESCRIPTION.chomp
    Enables an object to define an event method which to becomes a publisher/observable.
    Subscribers/observers can to be defined dynamically via a block given to the event.
  DESCRIPTION

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'version', '~> 1.0.0'
  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.48.1'
end
