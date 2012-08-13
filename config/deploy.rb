# coding: utf-8
require 'bundler/capistrano'
# require 'sidekiq/capistrano'

#require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.3-p194'
set :rvm_type, :user

set :application, "guaguale"
set :repository, "git://github.com/tomwey/guaguale.git"
set :branch, "master"
set :scm, :git
set :user, "railsu"
set :use_sudo, false
set :deploy_to, "/home/railsu/#{application}"
set :runner, "railsu"
set :git_shallow_clone, 1

role :web, "64.120.193.112"
role :app, "64.120.193.112"
role :db, "64.120.193.112", :primary => true
default_run_options[:pty] = true

after "deploy:update", "deploy:migrate"
after "deploy:migrate", "deploy:symbol_resource"

namespace :deploy do
  desc "Restart passenger process"
  task :restart, :roles => [:web], :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "copy everything to overwrite the shared public folder"
  task :symbol_resource do
      #拷贝新拉下来的images/css/jslib,以及目录下的文件
      run "rm -rf #{shared_path}/images/*"
      run "cp -r #{current_public}/images/* #{shared_path}/images/"
      run "rm -rf #{shared_path}/css/*"
      run "cp -r #{current_public}/css/* #{shared_path}/css/"
      run "rm -rf #{shared_path}/jslib/*"
      run "cp -r #{current_public}/jslib/* #{shared_path}/jslib/"
      run "rm -f #{shared_path}/*.*"
      run "cp #{current_public}/*.* #{shared_path}"
      #然后把拉下来的public目录删除掉
      run "rm -rf #{current_public}"
      #把共享的share文件夹中
      run "ln -sf #{shared_path} #{current_public}"
    end
    
end
# ssh_options[:forward_agent] = true
# default_run_options[:pty] = true

