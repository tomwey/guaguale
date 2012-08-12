set :application, "guaguale"
set :domain, "64.120.193.112"
set :repository, "git@github.com:tomwey/guaguale.git"
set :deploy_to, "/home/railsu/guaguale"

role :app, domain
role :web, domain
role :db,domain, :primary => true

set :deploy_via, :remote_cache
set :deploy_env, "production"
set :rails_env, "production"
set :scm, :git
set :branch, "master"
set :scm_verbose, true
set :use_sudo, false

set :user, "railsu"
set :group, "railsu"

default_environment["PATH"] = "/home/railsu/.rvm/rubies/ruby-1.9.3-p194/bin:/home/railsu/.rvm/gems/ruby-1.9.3-p194@global/bin:/usr/local/bin:/usr/bin:/bin:"
namespace :deploy do
  desc "restart"
  task :restart do
  run "touch #{current_path}/tmp/restart.txt"
end
end

desc "Create database.yml and asset packages for production"
after("deploy:update_code") do
  db_config = "#{shared_path}/config/database.yml.production"
  run "cp #{db_config} #{release_path}/config/database.yml"
end