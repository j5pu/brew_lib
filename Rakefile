# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require_relative "lib/brew_lib"

def version
  `git describe --tags --abbrev=0`.chomp
end

desc "Show all tasks in current Rakefile, to see descriptions rake -T or rake -D"
task :all do
  Rake::Task.tasks.each do |task|
    puts task.inspect
  end
end

desc "Show tasks in current Rakefile, to see descriptions rake -T or rake -D"
task :tasks do
  sh "rake", "--tasks"
end

desc "Create a new release and push [patch|minor|major], default is patch"
task bump: [:test] do |t, args|
  part = args.to_a.fetch(0, "patch")
  sh "git add -A && { git commit --quiet -m 'bump #{part}' 2>/dev/null || true; } &&
           gem bump --silent --quiet --tag --push --release && gh release create #{version} --generate-notes"
  puts args.to_a.fetch(0, "minor")
end

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
end

require "rubocop/rake_task"

RuboCop::RakeTask.new

# rake --tasks
task default: %i[test rubocop]
