# frozen_string_literal: true

$:.unshift File.expand_path('../lib', __FILE__)
require "brew_lib/version"

Gem::Specification.new do |spec|
  spec.name = "gem_name"
  spec.version = BrewLib::VERSION
  spec.authors = ["root"]
  spec.email = ["root@example.com"]

  spec.summary = "Brew lib."
  spec.description = "Brew lib."
  spec.homepage = "https://github.com/j5pu/brew_lib"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # noinspection RubyMismatchedArgumentType
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions  = %w( ext/wrapper_installer/extconf.rb )
  output = `lsof -p #{Process.ppid} | grep cwd`.split(" ").last
  spec.post_install_message = "Post-install: #{output}"

  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "activesupport", "< 7"
  spec.add_dependency "awesome_print"
  spec.add_dependency "bundle"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "gem-release"
  # gem bootstrap new_gem_test --bin --rspec --push --github --pretend
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
