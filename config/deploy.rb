# coding: utf-8
require 'bundler/capistrano'

set :keep_releases, 10
set :application, "guaguale"
set :repository, "git://github.com/tomwey/guaguale.git"
set :branch, "master"
set :scm, :git
set :user, "railsu"
#set :scm_passphrase, "tomwey"
set :use_sudo, false
set :deploy_to, "/home/railsu/#{application}"
set :current_public, "/home/railsu/#{application}/current/public"
set :shared_path, "/home/railsu/#{application}/shared"
set :deploy_via, :remote_cache
set :runner, "railsu"
set :git_shallow_clone, 1

role :web, "64.120.193.112"
role :app, "64.120.193.112"
role :db, "64.120.193.112", :primary => true

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

after "deploy:finalize_update", "deploy:symlink_shared"
after "deploy:update", "deploy:cleanup"

namespace :deploy do
  desc "Restart passenger process"
  task :restart, :roles => [:web], :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  task :seed do  
      run "cd #{current_path}; rake db:seed RAILS_ENV=production"  
  end
  
  # desc "Symlink shared resources on each release - not used"
  task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
      
end