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

execute "install ruby #{ruby_version}" do
  user "vagrant"
  command "#{rvm} install #{ruby_version}"
  not_if "ls #{rvm_home}/rubies | grep ruby-#{ruby_version}"
end

rvmsudo = "#{rvm} 1.8.7 && #{rvm_home}/bin/rvmsudo"

execute "Update ruby gems" do
  user "vagrant"
  command "#{rvmsudo} gem update --system"
end

execute "set ruby #{ruby_version} as default" do
  user "vagrant"
  command "#{rvm} --default #{ruby_version}"
end