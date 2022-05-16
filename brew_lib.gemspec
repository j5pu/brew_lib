# frozen_string_literal: true

# noinspection RubyMismatchedArgumentType
$LOAD_PATH.unshift File.expand_path("lib", __dir__)
require "brew_lib"

Gem::Specification.new do |spec|
  spec.name = BrewLib::NAME
  spec.version = BrewLib::VERSION
  spec.authors = ["root"]
  spec.email = ["root@example.com"]

  spec.summary = BrewLib.name.to_s
  spec.description = BrewLib.name.to_s
  spec.homepage = "https://github.com/j5pu/#{spec.name}"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # noinspection RubyMismatchedArgumentType
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "awesome_print"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "bundle"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "gem-release"
  spec.add_development_dependency "irb"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rb-readline"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-minitest"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"
end
