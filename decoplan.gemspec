lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'decoplan/version'

Gem::Specification.new do |gem|
  gem.name           = 'decoplan'
  gem.version        = Decoplan::VERSION
  gem.license        = 'Apache 2.0'
  gem.author         = 'lamont@scriptkiddie.org'
  gem.email          = 'lamont@scriptkiddie.org'
  gem.summary        = 'Decoplanner with a Pry-based REPL.'
  gem.description    = gem.summary
  gem.homepage       = 'https://github.com/lamont-granquist/decoplan'

  gem.required_ruby_version = '>= 2.1.0'

  gem.files = `git ls-files`.split($/)
  gem.bindir = 'bin'
  gem.executables = %w(decoplan)
  gem.test_files = gem.files.grep(/^spec\//)
  gem.require_paths = ['lib']

  gem.add_dependency 'pry'

  gem.add_development_dependency 'rspec',       '~> 3.0'
  gem.add_development_dependency 'rake'
end
