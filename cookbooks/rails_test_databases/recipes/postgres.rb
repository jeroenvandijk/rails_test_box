require_recipe "postgresql::dev"

execute "Create postgres vagrant user" do
  user "postgres"
  command "/usr/bin/createuser vagrant -dRs"
  not_if %[echo "select usename from pg_user" | psql | grep vagrant], :user => 'postgres'
end

execute "Build postgresql databases" do
  user "vagrant"
  cwd "/home/vagrant/rails/activerecord"
  command "rake postgresql:build_databases"
  not_if %[echo "select datname from pg_database" | psql | grep activerecord], :user => 'postgres'
end


