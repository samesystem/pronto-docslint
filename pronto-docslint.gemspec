# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'pronto/docslint/version'

Gem::Specification.new do |s|
  s.name = 'pronto-docslint'
  s.version = Pronto::DocslintVersion::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Justinas Matulevicius']
  s.email = 'justinas@samesystem.com'
  s.summary = <<-EOF
    Pronto runner for documentation existance.
  EOF
  s.required_ruby_version = '>= 2.0.0'
  s.rubygems_version = '1.8.23'

  s.files = Dir.glob('{lib}/**/*') + %w(README.md)
  s.extra_rdoc_files = ['README.md']
  s.require_paths = ['lib']

  s.add_dependency('pronto', '~> 0.9.0')
  s.add_dependency('rugged', '~> 0.24', '>= 0.23.0')
end
