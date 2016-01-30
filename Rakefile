
require "bundler/gem_tasks"

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

begin
  require "bundler/audit/cli"
  namespace :bundle do
    desc "Updates the ruby-advisory-db then runs bundle-audit"
    task :audit do
      %w{update check}.each do |command|
        Bundler::Audit::CLI.start [command]
      end
    end
  end
rescue LoadError
end

begin
  require "finstyle"
  require "rubocop/rake_task"
  RuboCop::RakeTask.new do |task|
    task.options << "--display-cop-names"
  end
rescue LoadError
end

namespace :travis do
  desc "Run test on Travis"
  task ci: %w{spec rubocop}
end

task default: %w{spec bundle:audit rubocop}
