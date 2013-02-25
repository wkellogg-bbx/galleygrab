# 1. Setup your application under version control using either Git or Subversion
# 2. Install any gems your application needs on your VPS as the root user using the gem install command
# 3. On your local machine change to your application directory and run "capify ."
# 4. Place this deploy.rb in your /config directory
# 5. Edit all of the variables below
# 6. In LxAdmin, click on Domains, then the domain for this application, next click Document Root and set the document root to: applicationname/current/public. This should be the same as the applicationname you set below
# 7. Make sure you database.yml is updated with your current production database settings
# 7. Run: "cap deploy:setup" , this will setup the capistrano directory structure
# 8. Run "cap deploy:cold", this will deploy your application on to the server and run your database migration.

### Deploy a new revision ###
# 1. Run "cap deploy"


###### INSTRUCTIONS ########## 
### Requirements: This requires an LxAdmin VPS configured to use Apache and Passenger

### First Run ###
# 1. Setup your application under version control using either Git or Subversion
# 2. Install any gems your application needs on your VPS as the root user using the gem install command
# 3. On your local machine change to your application directory and run "capify ."
# 4. Place this deploy.rb in your /config directory
# 5. Edit all of the variables below
# 6. In LxAdmin, click on Domains, then the domain for this application, next click Document Root and set the document root to: applicationname/current/public. This should be the same as the applicationname you set blow
# 7. Make sure you database.yml is updated with your current production database settings
# 7. Run: "cap deploy:setup" , this will setup the capistrano directory structure
# 8. Run "cap deploy:cold", this will deploy your application on to the server and run your database migration.

### Deploy a new revision ###
# 1. Run "cap deploy"

##############################
# The following variables will need to be changed:

# The ip address of your VPS
set :ip_address, "74.63.13.174"

# Your svn / git login name
set :scm_username , "ddrabik"

# Your repository type, by default we use subversion.
set :scm, :subversion
# If you are using git, uncomment the following line and comment out the line above.
#set :scm, :git

# The name of your application, this will also be the folder were your application
# will be deployed to
set :application, "bookcase" 

# the url for your repository
set :repository,  "https://bbx.sourcerepo.com/bbx/#{application}"


###### There is no need to edit anything below this line ######

set :user , "root"
set :scm_password, Proc.new { CLI.password_prompt "SVN Password: "}
set :deploy_to, "/home/admin/#{application}"
set :shared_directory, "#{deploy_to}/shared"
set :use_sudo, false
set :group_writable, false
default_run_options[:pty] = true

role :app, ip_address
role :web, ip_address
role :db,  ip_address, :primary => true

task :after_update_code, :roles => [:web, :db, :app] do
  run "chmod 755 #{release_path}/public"
  run "chown admin:admin #{release_path} -R"
end

namespace :deploy do
  desc "restart passenger"
  task :restart do
    passenger::restart
  end
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end

end

namespace :passenger do
  desc "Restart passenger"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
