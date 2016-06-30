Gem::Specification.new do |spec|
  spec.name          = 'lita-standups'
  spec.version       = '1.0.4'
  spec.authors       = ['Cristian Bica']
  spec.email         = ['cristian.bica@gmail.com']
  spec.description   = 'Lita standups'
  spec.summary       = 'Lita standups'
  spec.homepage      = 'https://github.com/cristianbica/lita-standups'
  spec.license       = 'MIT'
  spec.metadata      = { 'lita_plugin_type' => 'handler' }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'lita', '>= 4.7'
  spec.add_runtime_dependency 'lita-wizard'
  spec.add_runtime_dependency 'rufus-scheduler'
  spec.add_runtime_dependency 'ohm'
  spec.add_runtime_dependency 'ohm-contrib'
  spec.add_runtime_dependency 'activesupport'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rspec', '>= 3.0.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls'
end
