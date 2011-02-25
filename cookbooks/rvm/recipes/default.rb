home = "/home/vagrant"
rvm_home = "#{home}/.rvm"
rvm = "#{rvm_home}/bin/rvm"

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

cookbook_file "#{home}/.bash_profile" do
  source "bash_profile"
  owner "vagrant"
  group "vagrant"
  mode 0777
end