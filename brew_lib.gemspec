# frozen_string_literal: true

require_relative "lib/brew_lib/version"

Gem.pre_install do |installer|
  puts "Pre-install: setting message "
  output = `lsof -p #{Process.ppid} | grep cwd`.split(" ").last
  installer.spec.post_install_message = "Post-install: #{output}"
end

Gem.post_install do |post|
  puts "Post-install: setting message "
  puts post
end

Gem::Specification.new do |spec|
  spec.name = "brew_lib"
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
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "awesome_print"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
