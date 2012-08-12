require 'capistrano/ext/multistage'
require 'bundler/capistrano'

set :stages, %w(staging production)
set :default_stage, "production"

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
