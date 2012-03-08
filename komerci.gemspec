# -*- encoding: utf-8 -*-
require File.expand_path('../lib/komerci/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Rafael Souza"]
  gem.email         = ["me@rafaelss.com"]
  gem.description   = %q{Gem para integração com o Komerci da Redecard}
  gem.summary       = %q{Gem para integração com o Komerci da Redecard}
  gem.homepage      = "http://github.com/rafaelss/komerci"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "komerci"
  gem.require_paths = ["lib"]
  gem.version       = Komerci::VERSION
end
