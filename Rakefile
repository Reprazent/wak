require "bundler/gem_tasks"
task :test do
  $LOAD_PATH.unshift('lib', 'test')
  Dir.glob('./test/**/*_test.rb') { |f| require f }
end

task :default => :test


desc "Open an pry session with wak loaded"
task :console do
  sh "bundle exec pry -I lib -r wak.rb"
end
