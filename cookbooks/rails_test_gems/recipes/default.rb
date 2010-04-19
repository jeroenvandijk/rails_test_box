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