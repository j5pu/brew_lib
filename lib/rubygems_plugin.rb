# frozen_string_literal: true

# https://guides.rubygems.org/plugins/

require "pathname"
def run(action, installer)
  path = Pathname.new(installer.spec.lib_dirs_glob) / "#{action}.rb"
  if path.exist?
    delete = false
    unless $LOAD_PATH.include?(installer.spec.lib_dirs_glob)
      $LOAD_PATH.unshift installer.spec.lib_dirs_glob
      delete = true
    end
    #noinspection RubyResolve
    require action
    if delete
      $LOAD_PATH.delete installer.spec.lib_dirs_glob
    end
    true
  end
end

def msg(action, installer)
  puts "Finished: plugin: #{action} => #{installer.spec.name} (#{installer.spec.version})"
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
=begin
bundle clean --force
gem uninstall --ignore-dependencies --all -x
gem install bundle
bundle install
=end
