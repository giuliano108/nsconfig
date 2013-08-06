# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nsconfig/version'

Gem::Specification.new do |gem|
  gem.name          = "nsconfig"
  gem.version       = NSConfig::VERSION
  gem.authors       = ["Giuliano Cioffi"]
  gem.email         = ["giuliano@108.bz"]
  gem.description   = %q{Inject per-environment YAML config data into a module}
  gem.summary       = gem.description
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
