# TODO The following should be more like a recipe, but since a recipe is only executed once
#      it will only be execute again when make a definition. It would be better if there was
#      a command that run against all rubies versions like RVM does.
define :setup_rails_gems do
  Chef::Log.info "Setting up gems for Rails"

  home = "/home/vagrant"

  %w(bundler rake rb-inotify).each do |gem_name|
    execute "Run bundle install for rails" do
      command "gem install #{gem_name}"
      user "vagrant"
      cwd home
    end
  end

  # We need the following for the pg gem
  package "libpq-dev"

  # FIXME Need to correct the permissions on the .gem dir
  execute "chown -R vagrant:vagrant #{home}/.gem"

  execute "Run bundle install for rails" do
    command "bundle install"
    cwd "#{home}/rails"
    user "vagrant"
    not_if "bundle check", :cwd => "#{home}/rails"
  end
end