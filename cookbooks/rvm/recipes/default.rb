home = "/home/vagrant"
rvm_home = "#{home}/.rvm"
rvm = "#{rvm_home}/bin/rvm"

bash "install rvm" do
  user "vagrant"
  # Using the example command from http://rvm.beginrescueend.com
  # FIXME RVM does not work for us after the commit below. Find a better solution. 
  # Commit can be found here http://github.com/wayneeseguin/rvm/commit/852aa1e117034bebcdc0b4e930b4e29165bc0473
  code <<-EOH
    mkdir -p ~/.rvm/src/ 
    cd ~/.rvm/src
    rm -rf ./rvm/
    git clone git://github.com/wayneeseguin/rvm.git
    cd rvm
    git checkout 852aa1e117034bebcdc0b4e930b4e29165bc0473
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