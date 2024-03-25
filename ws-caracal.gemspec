# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'caracal/version'

Gem::Specification.new do |spec|
  spec.name          = 'ws-caracal'
  spec.version       = '1.1.0.2'
  spec.authors       = ['WSGR', 'Trade Infomatics', 'John Dugan']
  spec.email         = 'no-reply@wsgr.com'
  spec.summary       = %q{ Fast, professional Microsoft Word (docx) writer for Ruby. }
  spec.description   = %q{ Caracal is a pure Ruby Microsoft Word generation library that produces professional quality MSWord documents (docx) using a simple, HTML-style DSL. }
  spec.homepage      = 'https://github.com/trade-informatics/caracal'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'nokogiri', '~> 1.6'
  spec.add_dependency 'rubyzip',  '~> 1.1'
  spec.add_dependency 'tilt',     '>= 1.4'

  spec.add_dependency 'evt-initializer'

  spec.add_dependency 'ws-docx-fixtures'
end
