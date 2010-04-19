require_recipe "mysql::server"

remote_file "/tmp/rails_mysql_user_grants.sql"

mysql_shell = "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]}"

execute "Create Mysql Rails user" do
  command "mysql_shell < /tmp/rails_mysql_user_grants.sql"
  not_if %[echo "select User from mysql.user" | #{mysql_shell} | grep rails]
end

execute "Build mysql databases" do
  user "vagrant"
  cwd "/home/vagrant/rails/activerecord"
  command "rake mysql:build_databases"
  not_if %[echo "show databases" | #{mysql_shell} | grep activerecord]
end