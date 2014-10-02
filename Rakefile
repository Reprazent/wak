require "bundler/gem_tasks"
require 'rake/testtask'

desc 'Run Devise unit tests.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

task :default => :test


desc "Open an pry session with wak loaded"
task :console do
  sh "bundle exec pry -I lib -r wak.rb"
end
