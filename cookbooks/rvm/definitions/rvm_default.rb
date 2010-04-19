define :rvm_default do
  ruby_version = RVM.ruby_version params[:name]
  
  rvm = "/home/vagrant/.rvm/bin/rvm"
  
  # rvm_default
  execute "set ruby #{ruby_version} as default" do
    user "vagrant"
    command "#{rvm} --default #{ruby_version}"
  end
  
end