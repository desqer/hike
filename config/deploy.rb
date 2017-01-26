require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/puma'

set :application_name, 'hike'
set :domain, 'hike.desqer.com'
set :user, 'desqer'
set :forward_agent, true
set :deploy_to, '/home/desqer/apps/hike'
set :repository, 'git@github.com:desqer/hike.git'
set :branch, 'master'

set :shared_files, fetch(:shared_files, []).push(
  'config/database.yml',
  'config/secrets.yml',
  'tmp/pids',
  'tmp/sockets',
  'public/uploads'
)

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  invoke :'rbenv:load'
end

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :'puma:restart'
    end
  end
end
