# TODO The following should be more like a recipe, but since a recipe is only executed once
#      it will only be execute again when make a definition. It would be better if there was
#      a command that run against all rubies versions like RVM does.
define :setup_rails_gems do
  Chef::Log.info "Setting up gems for Rails"
  
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
end