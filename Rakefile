require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'gem_versioner'

RSpec::Core::RakeTask.new('spec')

task :default => :spec
task :test => :spec

GemVersioner.configure(
  repo_url: 'https://github.com/Spokeo/geolookup',
  valid_branches: ['master']
)
