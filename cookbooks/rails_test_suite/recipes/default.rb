home = "/home/vagrant"
rvm_home = "#{home}/.rvm"
rvm     = "#{rvm_home}/bin/rvm"
rvmsudo = "#{rvm_home}/bin/rvmsudo"
rvm_gem = "#{rvm_home}/rubies/ruby-1.8.7-p249/bin/gem"

execute "Install bundler and rake gems" do 
  command "#{rvmsudo} #{rvm_gem} install bundler rake"
  user "vagrant"
  group "vagrant"
end

bundle_command = "#{rvm} 1.8.7 && #{rvmsudo} #{rvm_home}/rubies/ruby-1.8.7-p249/lib/ruby/gems/1.8/bin/bundle install vendor"

bundle_dirs = [ "#{home}/rails" ] + 
              %w(activesupport activemodel actionpack actionmailer activeresource activerecord railties).map { |dir| "#{home}/rails/#{dir}" }

bundle_dirs.each do |dir|
  execute "Run bundle install for #{dir}" do
    command bundle_command
    cwd dir
    user "vagrant"
  end
end

remote_file "/tmp/rails_mysql_user_grants.sql"

execute "Create Mysql Rails user" do
  command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} < /tmp/rails_mysql_user_grants.sql"
  ignore_failure true # FIXME Should be more like create if not exist, but don't know what to use 
end

execute "Create postgres vagrant user" do
  user "postgres"
  command "/usr/bin/createuser vagrant -dRS"
  ignore_failure true # FIXME Should be more like create if not exist, but don't know what to use 
end

rvm_rake = "#{rvm_home}/gems/ruby-1.8.7-p249%global/bin/rake"
rake = "#{rvm} 1.8.7 && #{rvm_rake}"
activerecord_path = "#{home}/rails/activerecord"

%w(mysql postgresql).each do |database|
  # First we are gonna drop the database to make sure creating on succeeds
  execute "Drop #{database} databases" do
    user "vagrant"
    cwd activerecord_path
    command "#{rake} #{database}:drop_databases"
    ignore_failure true
  end

  execute "Build #{database} databases" do
    user "vagrant"
    cwd activerecord_path
    command "#{rake} #{database}:build_databases"
  end
end

# Add memcache