require "rake"
require "rake/testtask"

desc "Default: run unit tests"
task :default => :test

desc "Test the bindings."
Rake::TestTask.new() do |t|
  t.libs << "lib"
  t.pattern = "tests/test_*.rb"
  t.verbose = true
end
