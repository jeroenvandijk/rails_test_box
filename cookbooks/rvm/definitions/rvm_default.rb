define :rvm_default do
  ruby_version = RVM.ruby_version params[:name]
  
  # rvm_default
  execute "set ruby #{ruby_version} as default" do
    user "vagrant"
    command "/home/vagrant/.rvm/bin/rvm --default #{ruby_version}"
  end
  
end