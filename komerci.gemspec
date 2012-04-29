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

  gem.add_dependency "rest-client", "~> 1.6.7"
  gem.add_dependency "nokogiri", "~> 1.5.2"
  gem.add_development_dependency "rspec", "~> 2.9.0"
  gem.add_development_dependency "webmock", "~> 1.8.6"
end
