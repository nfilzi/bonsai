# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

desc "Look for style guide offenses in your code"
task :rubocop do
  sh "rubocop --format simple || true"
end

Rails.application.load_tasks

task default: [:rubocop, :spec]
