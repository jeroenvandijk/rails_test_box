define :rvm_install do
  ruby_version = RVM.ruby_version params[:name]
  
  require_recipe "java" if ruby_version =~ /^jruby/
  
  package "libreadline5-dev" if ruby_version =~ /^ree/
  
  require_recipe "mono" if ruby_version =~ /^ironruby/
  
  execute "install ruby #{ruby_version}" do
    user node[:rvm][:user] 
    command "#{node[:rvm][:bin]}/rvm install #{ruby_version}"
    not_if "ls #{node[:rvm][:home]}/rubies | grep #{ruby_version}"
  end

  if ruby_version =~ /^ruby/
    # part of the rvm_install is the openssl recompilation (from http://cjohansen.no/en/ruby/ruby_version_manager_ubuntu_and_openssl)
    package "libssl-dev"

    execute "Fix install openssl for RVM #{ruby_version}" do
      user "vagrant"
      command "cd #{node[:rvm][:home]}/src/#{ruby_version}/ext/openssl && ruby extconf.rb && make install"
      not_if { File.exist?("#{node[:rvm][:home]}/.rvm/rubies/#{ruby_version}/lib/ruby/site_ruby/1.8/openssl") } # does not work for 1.9.1
    end
  end
end