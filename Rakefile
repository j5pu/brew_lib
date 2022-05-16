# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require_relative "lib/brew_lib"

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

task bump: [:test] do |t, args|
  raise = args.to_a.fetch(0, "minor")
  a = sh "git add -A && { git commit -m 'bump #{raise}' || true; } && gem bump --tag --push --release"
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
