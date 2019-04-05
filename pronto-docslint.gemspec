# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'pronto/docslint/version'

Gem::Specification.new do |spec|
  spec.name = 'pronto-docslint'
  spec.version = Pronto::DocslintVersion::VERSION
  spec.authors = ['Justinas Matulevicius']
  spec.email = 'justinas@samesystem.com'

  spec.homepage = 'https://github.com/samesystem/pronto-docslint'
  spec.summary = 'Pronto runner for documentation existance.'
  spec.license = 'MIT'

  spec.rubygems_version = '1.8.23'

  spec.files = Dir.glob('{lib}/**/*') + %w(README.md)
  spec.extra_rdoc_files = ['README.md']
  spec.require_paths = ['lib']

  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.0.0'
  spec.add_dependency('pronto', '~> 0.9.0')
  spec.add_dependency('rugged', '~> 0.24', '>= 0.23.0')
end
