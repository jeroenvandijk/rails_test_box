require_recipe "apt"
require_recipe "git"
require_recipe "build-essential"
require_recipe "zlib"
require_recipe "curl"

require_recipe "rails_test_databases"

require_recipe "rvm"

node[:rubies].each do |version|
  rvm_install version
  setup_rails_gems
end

rvm_default node[:rubies].first

mysql_shell = "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]}"

execute "Build mysql databases" do
  user "vagrant"
  cwd "/home/vagrant/rails/activerecord"
  command "rake mysql:build_databases"
  not_if %[echo "show databases" | #{mysql_shell} | grep activerecord]
end

execute "Build postgresql databases" do
  user "vagrant"
  cwd "/home/vagrant/rails/activerecord"
  command "rake postgresql:build_databases"
  not_if %[echo "select datname from pg_database" | psql | grep activerecord], :user => 'postgres'
end