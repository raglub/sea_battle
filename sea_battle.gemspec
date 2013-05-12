# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sea_battle/version'

Gem::Specification.new do |spec|
  spec.name          = "sea_battle"
  spec.version       = SeaBattle::VERSION
  spec.authors       = ["Michał Szyma"]
  spec.email         = ["raglub.ruby@gmail.com"]
  spec.description   = %q{Sea Battle is a guessing game for two players}
  spec.summary       = %q{It is a popular game Battleship}
  spec.homepage      = "https://github.com/raglub/sea_battle"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
