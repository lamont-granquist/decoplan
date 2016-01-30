
require 'bundler/gem_tasks'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

namespace :travis do
  desc 'Run test on Travis'
  task ci: %w{spec}
end

task default: %w{spec}
