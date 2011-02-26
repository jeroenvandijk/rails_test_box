require_recipe "postgresql::server"

execute "Create postgres vagrant user" do
  user "postgres"
  command "/usr/bin/createuser vagrant -dRs"
  not_if %[echo "select usename from pg_user" | psql | grep vagrant], :user => 'postgres'
end


