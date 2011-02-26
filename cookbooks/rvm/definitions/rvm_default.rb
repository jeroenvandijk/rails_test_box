define :rvm_default do
  rvm_ruby = RVM::Ruby.new params[:name]
  
  # rvm_default
  execute "set ruby #{rvm_ruby.version} as default" do
    user "vagrant"
    command "/home/vagrant/.rvm/bin/rvm --default #{rvm_ruby.version}"
  end
  
end