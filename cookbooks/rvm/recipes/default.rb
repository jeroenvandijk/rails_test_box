bash "install rvm" do
  user "vagrant"
  code <<-EOH
    mkdir -p ~/.rvm/src/ 
    cd ~/.rvm/src
    rm -rf ./rvm/
    git clone --depth 1 git://github.com/wayneeseguin/rvm.git
    cd rvm 
    ./install
  EOH
  not_if { File.exists?("/home/vagrant/.rvm") }
end

remote_file "/home/vagrant/.bash_profile" do
  source "bash_profile"
  owner "vagrant"
  group "vagrant"
  mode 0777
end

ruby_version = "1.8.7"
rvm_bin = "/home/vagrant/.rvm/bin/rvm"

execute "install ruby #{ruby_version}" do
  user "vagrant"
  command "#{rvm_bin} install #{ruby_version}"
  not_if "ls /home/vagrant/.rvm/rubies | grep ruby-#{ruby_version}"
end

rvm = "/home/vagrant/.rvm/bin/rvm"
rvmsudo = "#{rvm} 1.8.7 && /home/vagrant/.rvm/bin/rvmsudo"

# Does this work?
execute "Update ruby gems" do
  user "vagrant"
  command "#{rvmsudo} gem update --system"
end

execute "set ruby #{ruby_version} as default" do
  user "vagrant"
  command "#{rvm_bin} --default #{ruby_version}"
end