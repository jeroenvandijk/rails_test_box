# Update rubygems, for bundler
execute "gem update --system"

gem_package "bundler"
gem_package "rake"

home = "/home/vagrant"

execute "Run bundle install for rails" do
  command "bundle install"
  cwd "#{home}/rails"
  user "vagrant"
  not_if "bundle check", :cwd => "#{home}/rails"
end

remote_file "/tmp/rails_mysql_user_grants.sql"

execute "Create Mysql Rails user" do
  command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} < /tmp/rails_mysql_user_grants.sql"
  not_if %[echo "select User from mysql.user" | /usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} | grep rails]
end

execute "Create postgres vagrant user" do
  user "postgres"
  command "/usr/bin/createuser vagrant -dRs"
  not_if %[echo "select usename from pg_user" | psql | grep vagrant], :user => 'postgres'
end

activerecord_path = "#{home}/rails/activerecord"

%w(mysql postgresql).each do |database|
  # First we are gonna drop the database to make sure creating on succeeds
  execute "Drop #{database} databases" do
    user "vagrant"
    cwd activerecord_path
    command "rake #{database}:drop_databases"
    ignore_failure true
  end

  execute "Build #{database} databases" do
    user "vagrant"
    cwd activerecord_path
    command "rake #{database}:build_databases"
  end
end