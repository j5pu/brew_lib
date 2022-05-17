# frozen_string_literal: true

# https://guides.rubygems.org/plugins/
# https://github.com/rvm/executable-hooks/blob/master/lib/rubygems_plugin.rb
require "pathname"
def run(action, installer)
  path = Pathname.new(installer.spec.lib_dirs_glob) / "#{action}.rb"
  return unless path.exist?

  delete = false
  unless $LOAD_PATH.include?(installer.spec.lib_dirs_glob)
    $LOAD_PATH.unshift installer.spec.lib_dirs_glob
    delete = true
  end
  # noinspection RubyResolve
  require action
  $LOAD_PATH.delete installer.spec.lib_dirs_glob if delete
  true
end

Gem.pre_install do |installer|
  run "pre_install", installer
end

Gem.pre_uninstall do |installer|
  run "pre_uninstall", installer
end

Gem.post_build do |installer|
  run "post_build", installer
end

Gem.post_install do |installer|
  run "post_install", installer
end

Gem.post_uninstall do |installer|
  run "post_uninstall", installer
end

# TODO: el caller o que solo se haga una vez
# bundle clean --force
# gem uninstall --ignore-dependencies --all -x
# gem install bundle bundler irb
# bundle install
# sudo gem update --system
