# frozen_string_literal: true

require "mina/bundler"
require "mina/rails"
require "mina/git"
require "mina/puma"
# require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
require "mina/rvm" # for rvm support. (https://rvm.io)
require File.expand_path("./environment", __dir__)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :application_name, "recruitment"
set :domain, ENV["DOMAIN"]
set :deploy_to, ENV["DEPLOY_TO"]
set :repository, "git@github.com:Avegen/recruitment.git"
set :branch, "master"

# Optional settings:
set :user, ENV["SSH_USER"] # Username in the server to SSH to.
set :port, ENV["SSH_PORT"] || "22" # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
set :shared_dirs, fetch(:shared_dirs, []).push("node_modules", "log", "tmp/pids", "tmp/sockets")
set :shared_files, fetch(:shared_files, []).push(".env", "config/puma.rb", "app/webpack/packs/images/logo.png",
                                                 "config/master.key")
set :asset_dirs, ["app/assets/images", "app/assets/javascripts",
                  "app/assets/stylesheets", "vendor/assets", "app/webpack/packs/images",
                  "app/webpack/packs/javascripts", "app/webpack/packs/stylesheets"]
set :commit, ENV["COMMIT"]

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  invoke :"rvm:use", "ruby-2.5.1@recruitment"
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  command %{rvm install 2.5.1}
  command %[touch "#{fetch(:shared_path)}/config/puma.rb"]
  comment "Be sure to edit '#{fetch(:shared_path)}/config/puma.rb .env"
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :"git:ensure_pushed"
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :"git:clone"
    invoke :"deploy:link_shared_paths"
    invoke :"bundle:install"
    invoke :"yarn:install"
    command %{#{fetch(:rails)} db:seed}
    invoke :"rails:db_migrate"
    invoke :"rails:assets_precompile"
    invoke :"deploy:cleanup"

    on :launch do
      invoke :"puma:phased_restart"
      invoke :"nginx:restart"
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

namespace :nginx do
  task :start do
    comment "Start Nginx"
    command "sudo service nginx start"
  end

  task :restart do
    comment "Restart Nginx"
    command "sudo service nginx restart"
  end
end

namespace :yarn do
  task :install do
    comment "Install npm dependencies"
    command "yarn install --check-files"
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
