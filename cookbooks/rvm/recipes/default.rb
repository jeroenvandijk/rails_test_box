home = "/home/vagrant"
rvm_home = "#{home}/.rvm"
rvm = "#{rvm_home}/bin/rvm"

ruby_version = "1.8.7" # Add more ruby versions here?

bash "install rvm" do
  user "vagrant"
  # Using the example command from http://rvm.beginrescueend.com
  code <<-EOH
    mkdir -p ~/.rvm/src/ 
    cd ~/.rvm/src
    rm -rf ./rvm/
    git clone --depth 1 git://github.com/wayneeseguin/rvm.git
    cd rvm 
    ./install
  EOH
  not_if { File.exists?(rvm_home) }
end

remote_file "#{home}/.bash_profile" do
  source "bash_profile"
  owner "vagrant"
  group "vagrant"
  mode 0777
end


ruby_version = "1.8.7-p249"
# Move the ruby specific stuff into a definition e.g. all the stuff below
# rvm_install 
execute "install ruby #{ruby_version}" do
  user "vagrant"
  command "#{rvm} install #{ruby_version}"
  not_if "ls #{rvm_home}/rubies | grep ruby-#{ruby_version}"
end

# rvm_default
execute "set ruby #{ruby_version} as default" do
  user "vagrant"
  command "#{rvm} --default #{ruby_version}"
end

# rvm_use version
ruby_block "rvm use rbx" do
  block do    
    Chef::Mixin::Command.popen4(%{bash -l -c "rvm_path=#{rvm_home} &&  #{rvm_home}/bin/rvmsudo && source /home/vagrant/.rvm/scripts/rvm && env"}) do |p,i,o,e|
      o.each_line do |line|
        env_bits = line.strip.split("=")
        ENV[env_bits[0]] = env_bits[1]

      end
    end
    
  end
end

# part of the rvm_install is the openssl compilation (from http://cjohansen.no/en/ruby/ruby_version_manager_ubuntu_and_openssl)
package "libssl-dev"

execute "Fix install openssl for RVM #{ruby_version}" do
  command "cd /home/vagrant/.rvm/src/ruby-#{ruby_version}/ext/openssl && ruby extconf.rb && make install"
  not_if { File.exist?("/home/vagrant/.rvm/rubies/ruby-#{ruby_version}/lib/ruby/site_ruby/1.8/openssl") }
end